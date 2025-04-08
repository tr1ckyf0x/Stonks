import SwiftUI

struct MenuPopoverView: View {

    @ObservedObject private var viewModel: MenuPopoverViewModel

    init(viewModel: MenuPopoverViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
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
