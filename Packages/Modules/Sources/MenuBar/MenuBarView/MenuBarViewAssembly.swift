import CoinCapPriceService
import SwiftUI
import Swinject

public struct MenuBarViewAssembly: Assembly {
    public init() { }

    public func assemble(container: Container) {
        container.register(MenuBarView.self) { (resolver: Resolver) -> MenuBarView in
            let viewModel = resolver.resolve(MenuBarViewModel.self)!
            return MenuBarView(viewModel: viewModel)
        }

        container.register(MenuBarViewModel.self) { (resolver: Resolver) -> MenuBarViewModel in
            let coinCapPriceService = resolver.resolve(CoinCapPriceServiceProtocol.self)!
            return MenuBarViewModel(service: coinCapPriceService)
        }
    }
}
