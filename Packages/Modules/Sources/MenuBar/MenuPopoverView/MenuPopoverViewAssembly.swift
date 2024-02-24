import AnalyticsService
import CoinCapPriceService
import Swinject
import UpdateService

public struct MenuPopoverViewAssembly: Assembly {

    public init() { }

    public func assemble(container: Container) {
        container.register(MenuPopoverView.self) { (resolver: Resolver) -> MenuPopoverView in
            let viewModel = resolver.resolve(MenuPopoverViewModel.self)!
            return MenuPopoverView(viewModel: viewModel)
        }

        container.register(MenuPopoverViewModel.self) { (resolver: Resolver) -> MenuPopoverViewModel in
            let coinCapService = resolver.resolve(CoinCapPriceServiceProtocol.self)!
            let updateService = resolver.resolve(UpdateServiceProtocol.self)!
            let analyticsService = resolver.resolve(AnalyticsServiceProtocol.self)!
            return MenuPopoverViewModel(
                coinCapService: coinCapService,
                updateService: updateService,
                analyticsService: analyticsService
            )
        }
    }
}
