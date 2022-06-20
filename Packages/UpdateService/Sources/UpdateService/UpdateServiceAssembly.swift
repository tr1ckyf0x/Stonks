import Swinject
import Sparkle

public struct UpdateServiceAssembly: Assembly {

    public init() { }

    public func assemble(container: Container) {
        container.register(UpdateService.self) { _ in
            let updaterController = SPUStandardUpdaterController(
                startingUpdater: true,
                updaterDelegate: nil,
                userDriverDelegate: nil
            )
            return UpdateService(updaterController: updaterController)
        }
        .implements(UpdateServiceProtocol.self)
        .inObjectScope(.container)
    }
}
