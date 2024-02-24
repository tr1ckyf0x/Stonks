import AppKit
import Swinject

public struct StatusItemControllerAssembly: Assembly {

    public init() { }

    public func assemble(container: Container) {
        container.register(StatusItemController.self) { (
            _: Resolver,
            statusBar: NSStatusBar,
            assembler: Assembler
        ) -> StatusItemController in
            StatusItemController(statusBar: statusBar, assembler: assembler)
        }
        .implements(StatusItemControllerInput.self)
    }
}
