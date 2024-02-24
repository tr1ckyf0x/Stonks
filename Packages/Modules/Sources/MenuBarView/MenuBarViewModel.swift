import Combine
import Foundation
import SwiftUI
import MenuBarModels
import CoinCapPriceService
import MenuBarResources

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
        value: String = .init(),
        service: CoinCapPriceServiceProtocol
    ) {
        self.value = value
        self.service = service
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

        self.value = value ?? MenuBarResources.L10n.updating
    }

}
