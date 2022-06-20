import Combine
import Foundation
import SwiftUI
import Models
import CoinCapPriceService
import MenuBarResources

public final class MenuBarViewModel: ObservableObject {

    @Published private(set) var name: String
    @Published private(set) var value: String
    @Published private(set) var color: Color
    @AppStorage(AppStorageKey.selectedCoinType.rawValue) private(set) var selectedCoinType = CoinType.bitcoin

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
        name: String = .init(),
        value: String = .init(),
        color: Color = .green,
        service: CoinCapPriceServiceProtocol
    ) {
        self.name = name
        self.value = value
        self.color = color
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
        self.name = selectedCoinType.description

        guard service.isConnected else {
            value = L10n.offline
            return
        }

        let value = service.coinDictionary[selectedCoinType]
            .map(NSNumber.init(value:))
            .flatMap(currencyFormatter.string(from:))

        self.value = value ?? MenuBarResources.L10n.updating

        self.color = self.service.isConnected ? .green : .red
    }

}
