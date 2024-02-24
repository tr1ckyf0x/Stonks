import Swinject

public struct AnalyticsServiceAssembly: Assembly {

    public init() { }

    public func assemble(container: Container) {
        container.register(AnalyticsService.self) { _ -> AnalyticsService in
            AnalyticsService()
        }
        .implements(AnalyticsServiceProtocol.self)
        .inObjectScope(.container)
    }
}
