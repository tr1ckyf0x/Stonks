import SwiftUI
import CryptoImageFactory

public struct MenuBarView: View {

    @ObservedObject var viewModel: MenuBarViewModel

    public init(viewModel: MenuBarViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
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
