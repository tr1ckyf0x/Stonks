import SwiftUI
import CryptoImageFactory

public struct MenuBarView: View {

    @ObservedObject var viewModel: MenuBarViewModel

    public init(viewModel: MenuBarViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        HStack(spacing: 8) {

            Image(
                nsImage: CryptoImageFactory.asset(
                    for: viewModel.selectedCoinType
                ).image
            )
            .resizable()
            .frame(height: 16)

            Text(viewModel.value)
                .font(.title3.monospacedDigit())

        }
        .padding([.leading, .trailing], 8)
        .fixedSize()
        .onChange(of: viewModel.selectedCoinType) { _ in
            viewModel.updateView()
        }
        .onAppear {
            viewModel.subscribeToService()
        }
    }
}

//#if DEBUG
//struct MenuBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuBarView(
//            viewModel: .init(
//                name: "Bitcoin",
//                value: "$40,000",
//                color: .green,
//                service: CoinCapPriceServiceMock()
//            )
//        )
//    }
//}
//#endif
