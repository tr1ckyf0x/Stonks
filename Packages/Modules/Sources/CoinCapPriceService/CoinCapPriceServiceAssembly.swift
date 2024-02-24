import Swinject
import Log

public struct CoinCapPriceServiceAssembly: Assembly {

    public init() { }

    public func assemble(container: Container) {
        container.register(CoinCapPriceService.self) { (resolver: Resolver) -> CoinCapPriceService in
            let log = resolver.resolve(LogProtocol.self)!
            return CoinCapPriceService(log: log)
        }
        .implements(CoinCapPriceServiceProtocol.self)
        .inObjectScope(.weak)
    }
}
