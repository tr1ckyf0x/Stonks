import CoinCapPriceService
import Combine
import ProtocolsAndModels
import SwiftUI

public final class MenuBarViewModel: ObservableObject {

    @Published var value: String
    @AppStorage(AppStorageKey.selectedCoinType.rawValue) var selectedCoinType = CoinType.bitcoin

    private let service: CoinCapPriceServiceProtocol
    private var subscriptions = Set<AnyCancellable>()

    private let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.currencyCode = "USD"
        formatter.currencySymbol = "$"
        return formatter
    }()

    public init(
        service: CoinCapPriceServiceProtocol,
        value: String = .init()
    ) {
        self.service = service
        self.value = value
    }

    func subscribeToService() {
        service.coinDictionarySubject
            .combineLatest(service.connectionStateSubject)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.updateView() }
            .store(in: &subscriptions)
    }

    func updateView() {

        guard service.isConnected else {
            value = String(localized: "Offline")
            return
        }

        let value = service.coinDictionary[selectedCoinType]
            .map(NSNumber.init(value:))
            .flatMap(currencyFormatter.string(from:))

        self.value = value ?? String(localized: "Updating")
    }

}
