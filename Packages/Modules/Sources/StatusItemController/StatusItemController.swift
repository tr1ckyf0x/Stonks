import AppKit
import MenuBar
import SwiftUI
import Swinject

final class StatusItemController: NSObject {

    private var assembler: Assembler!
    private var statusBarItem: NSStatusItem!

    private lazy var popover: NSPopover = { popover in
        popover.behavior = .transient
        popover.animates = true
        popover.contentViewController = NSViewController()
        popover.delegate = self
        return popover
    }(NSPopover())

    private lazy var contentView: NSView? = {
        let view = (statusBarItem.value(forKey: "window") as? NSWindow)?.contentView
        return view
    }()

    private lazy var assemblies: [Assembly] = [
        MenuBarViewAssembly(),
        MenuPopoverViewAssembly()
    ]

    init(statusBar: NSStatusBar, assembler: Assembler) {
        super.init()
        self.assembler = Assembler(assemblies, parent: assembler)
        createStatusBarItem(in: statusBar)
        setupPopover()
    }
}

// MARK: - StatusItemControllerInput
extension StatusItemController: StatusItemControllerInput {

}

// MARK: - Private methods
extension StatusItemController {
    private func createStatusBarItem(in statusBar: NSStatusBar) {
        statusBarItem = statusBar
            .statusItem(withLength: NSStatusItem.variableLength)

        guard let contentView = self.contentView else { return }

        if let menuButton = statusBarItem.button {
            menuButton.target = self
            menuButton.action = #selector(menuButtonClicked)
        }

        let menuBarView = assembler.resolver.resolve(MenuBarView.self)

        let hostingView = NSHostingView(rootView: menuBarView)
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hostingView)

        NSLayoutConstraint.activate([
            hostingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            hostingView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            hostingView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
    }

    private func setupPopover() {
        let menuPopoverView = assembler.resolver.resolve(MenuPopoverView.self)
        popover.contentViewController?.view = NSHostingView(
            rootView: menuPopoverView
        )
    }

    @objc func menuButtonClicked() {
        if popover.isShown {
            popover.performClose(nil)
            return
        }

        guard let menuButton = statusBarItem.button else { return }
        popover.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: .maxY)
        popover.contentViewController?.view.window?.makeKey()
    }
}

// MARK: - NSPopoverDelegate
extension StatusItemController: NSPopoverDelegate {
    func popoverDidClose(_ notification: Notification) {
    }
}
