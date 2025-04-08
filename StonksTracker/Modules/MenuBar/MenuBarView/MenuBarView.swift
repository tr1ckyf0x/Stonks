import SwiftUI

struct MenuBarView: View {

    @ObservedObject var viewModel: MenuBarViewModel

    init(viewModel: MenuBarViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        MenuBarContentView(
            selectedCoinType: viewModel.selectedCoinType,
            value: viewModel.value
        )
        .onAppear {
            viewModel.subscribeToService()
        }
        .onChange(of: viewModel.selectedCoinType) { _ in
            viewModel.updateView()
        }
    }
}
