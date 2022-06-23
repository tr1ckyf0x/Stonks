import Foundation
import SwiftUI
import Combine
import Models
import CoinCapPriceService
import MenuBarResources
import UpdateService

public final class MenuPopoverViewModel: ObservableObject {

    @AppStorage(AppStorageKey.selectedCoinType.rawValue) var selectedCoinType = CoinType.bitcoin
    @Published private(set) var coinTypes: [CoinType]
    @Published private(set) var title: String = .init()
    @Published private(set) var subtitle: String = .init()

    private let coinCapService: CoinCapPriceServiceProtocol
    private let updateService: UpdateServiceProtocol

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
        coinTypes: [CoinType] = CoinType.allCases,
        coinCapService: CoinCapPriceServiceProtocol,
        updateService: UpdateServiceProtocol
    ) {
        self.coinTypes = coinTypes
        self.coinCapService = coinCapService
        self.updateService = updateService
    }

    func subscribeToService() {
        coinCapService.coinDictionarySubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.updateView() }
            .store(in: &subscriptions)
    }

    func updateView() {
        title = selectedCoinType.description
        subtitle = valueText(for: selectedCoinType)
    }

    func valueText(for coinType: CoinType) -> String {
        let price = coinCapService.coinDictionary[coinType]
        let value = price
            .map(NSNumber.init(value:))
            .flatMap(currencyFormatter.string(from:))

        return value ?? MenuBarResources.L10n.updating
    }

    func checkForUpdates() {
        updateService.checkForUpdates()
    }
    
}
