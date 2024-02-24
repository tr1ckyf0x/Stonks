import Combine
import ProtocolsAndModels

public protocol CoinCapPriceServiceProtocol {
    var coinDictionarySubject: CurrentValueSubject<[CoinType: Double], Never> { get }
    var connectionStateSubject: CurrentValueSubject<Bool, Never> { get }
    var coinDictionary: [CoinType: Double] { get }
    var isConnected: Bool { get }

    func connect()
    func startMonitorNetworkConnectivity()
}
