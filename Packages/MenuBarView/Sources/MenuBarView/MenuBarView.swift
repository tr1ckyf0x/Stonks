import SwiftUI
#if DEBUG
import CoinCapPriceServiceMock
#endif

public struct MenuBarView: View {

    @ObservedObject var viewModel: MenuBarViewModel

    public init(viewModel: MenuBarViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        HStack(spacing: 4) {
            Circle()
                .foregroundColor(viewModel.color)

            VStack(alignment: .trailing, spacing: -2) {
                Text(viewModel.name)
                Text(viewModel.value)
            }
            .font(.caption)
        }
        .fixedSize()
        .onChange(of: viewModel.selectedCoinType) { _ in
            viewModel.updateView()
        }
        .onAppear {
            viewModel.subscribeToService()
        }
    }
}

#if DEBUG
struct MenuBarView_Previews: PreviewProvider {
    static var previews: some View {
        MenuBarView(
            viewModel: .init(
                name: "Bitcoin",
                value: "$40,000",
                color: .green,
                service: CoinCapPriceServiceMock()
            )
        )
    }
}
#endif
