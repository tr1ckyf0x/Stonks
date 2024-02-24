import AnalyticsService
import CoinCapPriceService
import Combine
import ProtocolsAndModels
import SwiftUI
import UpdateService

public final class MenuPopoverViewModel: ObservableObject {

    @AppStorage(AppStorageKey.selectedCoinType.rawValue) var selectedCoinType = CoinType.bitcoin {
        didSet {
            logCoinSelectionEvent()
        }
    }
    @Published private(set) var coinTypes: [CoinType]
    @Published private(set) var title: String = .init()
    @Published private(set) var subtitle: String = .init()

    private let coinCapService: CoinCapPriceServiceProtocol
    private let updateService: UpdateServiceProtocol
    private let analyticsService: AnalyticsServiceProtocol

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
        coinCapService: CoinCapPriceServiceProtocol,
        updateService: UpdateServiceProtocol,
        analyticsService: AnalyticsServiceProtocol,
        coinTypes: [CoinType] = CoinType.allCases
    ) {
        self.coinCapService = coinCapService
        self.updateService = updateService
        self.analyticsService = analyticsService
        self.coinTypes = coinTypes
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

        return value ?? String(localized: "Updating")
    }

    func checkForUpdates() {
        logPressedCheckForUpdates()
        updateService.checkForUpdates()
    }
}

// MARK: - Private

extension MenuPopoverViewModel {
    private func logCoinSelectionEvent() {
        analyticsService.logEvent(.selectedCoin(selectedCoinType.rawValue))
    }

    private func logPressedCheckForUpdates() {
        analyticsService.logEvent(.pressedCheckForUpdates)
    }
}
