import Swinject
import AppKit

public struct StatusItemControllerAssembly: Assembly {

    public init() { }

    public func assemble(container: Container) {
        container.register(StatusItemController.self) { (
            resolver: Resolver,
            statusBar: NSStatusBar,
            assembler: Assembler
        ) -> StatusItemController in
            StatusItemController(statusBar: statusBar, assembler: assembler)
        }
        .implements(StatusItemControllerInput.self)
    }
}
