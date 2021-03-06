#if DEBUG
import CoinCapPriceService
import Combine
import MenuBarModels

public final class CoinCapPriceServiceMock {
    public var coinDictionarySubject = CurrentValueSubject<[CoinType: Double], Never>([:])
    public var connectionStateSubject = CurrentValueSubject<Bool, Never>(false)

    public init() {

    }
}

extension CoinCapPriceServiceMock: CoinCapPriceServiceProtocol {
    public var coinDictionary: [CoinType: Double] { coinDictionarySubject.value }
    
    public var isConnected: Bool {
        true
    }

    public func connect() {
    }

    public func startMonitorNetworkConnectivity() {
    }
}
#endif
