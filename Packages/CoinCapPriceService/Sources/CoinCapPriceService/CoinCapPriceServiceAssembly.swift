import Swinject

public struct CoinCapPriceServiceAssembly: Assembly {

    public init() { }

    public func assemble(container: Container) {
        container.register(CoinCapPriceService.self) { _ -> CoinCapPriceService in
            CoinCapPriceService()
        }
        .implements(CoinCapPriceServiceProtocol.self)
        .inObjectScope(.weak)
    }
}
