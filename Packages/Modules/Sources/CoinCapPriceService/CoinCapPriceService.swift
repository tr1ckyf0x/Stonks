import Combine
import Foundation
import Log
import Network
import ProtocolsAndModels

public final class CoinCapPriceService: NSObject {

    public let coinDictionarySubject = CurrentValueSubject<[CoinType: Double], Never>([:])
    public let connectionStateSubject = CurrentValueSubject<Bool, Never>(false)

    private let session = URLSession(configuration: .default)
    private let monitor = NWPathMonitor()

    private var webSocketTask: URLSessionWebSocketTask?
    private var pingTryCount = 0

    private let log: LogProtocol

    public init(log: LogProtocol) {
        self.log = log
    }

    deinit {
        coinDictionarySubject.send(completion: .finished)
        connectionStateSubject.send(completion: .finished)
    }
}

// MARK: - CoinCapPriceServiceProtocol
extension CoinCapPriceService: CoinCapPriceServiceProtocol {
    public var coinDictionary: [CoinType: Double] { coinDictionarySubject.value }

    public var isConnected: Bool { connectionStateSubject.value }

    public func connect() {
        let coins = CoinType.allCases
            .map(\.rawValue)
            .joined(separator: ",")

        let url = URL(string: "wss://ws.coincap.io/prices?assets=\(coins)")
        guard let url = url else { return }

        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.delegate = self
        webSocketTask?.resume()
        self.receiveMessage()
        self.schedulePing()
    }

    public func startMonitorNetworkConnectivity() {
        monitor.pathUpdateHandler = { [weak self] (path: NWPath) in
            guard let self = self else { return }
            if path.status == .satisfied, self.webSocketTask == nil {
                self.connect()
            }

            if path.status != .satisfied {
                self.clearConnection()
            }
        }
        monitor.start(queue: .main)
    }
}

// MARK: - Private methods
extension CoinCapPriceService {
    private func receiveMessage() {
        webSocketTask?.receive { [weak self] (result: Result<URLSessionWebSocketTask.Message, Error>) in
            guard let self = self else { return }
            switch result {
            case let .success(message):
                switch message {
                case .string(let text):
                    self.log.verbose("Received text message: \(text)")
                    if let data = text.data(using: .utf8) {
                        self.onReceiveData(data)
                    }

                case .data(let data):
                    self.log.verbose("Received binary message: \(data)")
                    self.onReceiveData(data)

                default: break
                }
                self.receiveMessage()

            case .failure(let error):
                self.log.error("Failed to receive message: \(error.localizedDescription)")
            }
        }
    }

    private func onReceiveData(_ data: Data) {
        let decoder = JSONDecoder()
        let dictionary: [String: String]
        do {
            dictionary = try decoder.decode([String: String].self, from: data)
        } catch {
            return
        }

        let newDictionary = dictionary.reduce(into: [:]) { (
            result: inout [CoinType: Double],
            element: (key: String, value: String)
        ) in
            guard let type = CoinType(rawValue: element.key),
                  let value = Double(element.value)
            else { return }
            result[type] = value
        }

        let mergedDictionary = coinDictionary.merging(newDictionary) { $1 }
        coinDictionarySubject.send(mergedDictionary)
    }

    private func schedulePing() {
        let identifier = webSocketTask?.taskIdentifier ?? -1
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self = self,
                  let task = self.webSocketTask,
                  task.taskIdentifier == identifier
            else { return }

            guard task.state == .running, self.pingTryCount < 2 else {
                self.reconnect()
                return
            }

            self.pingTryCount += 1
            self.log.verbose("Ping: Send Ping \(self.pingTryCount)")
            task.sendPing { [weak self] error in
                if let error = error {
                    self?.log.error("Ping failed: \(error.localizedDescription)")
                    return
                }

                if self?.webSocketTask?.taskIdentifier == identifier {
                    self?.pingTryCount = 0
                }
            }
            self.schedulePing()
        }
    }

    private func reconnect() {
        clearConnection()
        connect()
    }

    private func clearConnection() {
        webSocketTask?.cancel()
        webSocketTask = nil
        pingTryCount = 0
        connectionStateSubject.send(false)
    }
}

// MARK: - URLSessionWebSocketDelegate
extension CoinCapPriceService: URLSessionWebSocketDelegate {

    public func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didOpenWithProtocol protocol: String?
    ) {
        connectionStateSubject.send(true)
    }

    public func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didCloseWith closeCode: URLSessionWebSocketTask.CloseCode,
        reason: Data?
    ) {
        connectionStateSubject.send(false)
    }

}
