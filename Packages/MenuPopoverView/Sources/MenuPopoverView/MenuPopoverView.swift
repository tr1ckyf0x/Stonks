import SwiftUI
import Models
#if DEBUG
import CoinCapPriceServiceMock
import UpdateServiceMock
#endif

public struct MenuPopoverView: View {

    @ObservedObject private var viewModel: MenuPopoverViewModel

    public init(viewModel: MenuPopoverViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(spacing: 16) {
            VStack {
                Text(viewModel.title).font(.largeTitle)
                Text(viewModel.subtitle).font(.title.bold())
            }

            Divider()
            
            Picker(L10n.selectCoin, selection: $viewModel.selectedCoinType) {

                ForEach(viewModel.coinTypes) { (type: CoinType) in
                    HStack {
                        Text(type.description).font(.headline)
                        Spacer()
                        Text(viewModel.valueText(for: type))
                            .frame(alignment: .trailing)
                            .font(.body)

                        Link(destination: type.url) {
                            Image(systemName: "safari")
                        }
                    }
                    .tag(type)
                }
            }
            .pickerStyle(RadioGroupPickerStyle())
            .labelsHidden()

            Divider()

            HStack {
                Button(L10n.checkForUpdates) {
                    viewModel.checkForUpdates()
                }

                Button(L10n.quit) {
                    NSApp.terminate(self)
                }
            }
            .padding(.bottom, 8)
        }
        .onChange(of: viewModel.selectedCoinType) { _ in
            viewModel.updateView()
        }
        .onAppear {
            viewModel.subscribeToService()
        }
    }
}

#if DEBUG
struct MenuPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        let coinCapService = CoinCapPriceServiceMock()
        let updateService = UpdateServiceMock()
        coinCapService.coinDictionarySubject.value = [
            .bitcoin: 500000,
            .ethereum: 30000,
            .solana: 1000
        ]
        let viewModel = MenuPopoverViewModel(
            coinCapService: coinCapService,
            updateService: updateService
        )
        return MenuPopoverView(viewModel: viewModel)
    }
}
#endif
