import SwiftUI
import MenuBarModels

public struct MenuPopoverView: View {

    @ObservedObject private var viewModel: MenuPopoverViewModel

    public init(viewModel: MenuPopoverViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        MenuPopoverContentView(
            title: viewModel.title,
            subtitle: viewModel.subtitle,
            selectedCoinType: $viewModel.selectedCoinType,
            coinTypes: viewModel.coinTypes,
            valueStringForType: { type in viewModel.valueText(for: type) },
            checkUpdatesAction: { viewModel.checkForUpdates() }
        )
        .onChange(of: viewModel.selectedCoinType) { _ in
            viewModel.updateView()
        }
        .onAppear {
            viewModel.subscribeToService()
        }
    }
}
