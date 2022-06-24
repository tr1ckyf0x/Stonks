import Swinject

public struct AnalyticsServiceAssembly: Assembly {

    public init() { }

    public func assemble(container: Container) {
        container.register(AnalyticsService.self) { (resolver: Resolver) -> AnalyticsService in
            return AnalyticsService()
        }
        .implements(AnalyticsServiceProtocol.self)
        .inObjectScope(.container)
    }
}
