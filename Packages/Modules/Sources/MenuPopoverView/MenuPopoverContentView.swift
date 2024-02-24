//
//  MenuPopoverContentView.swift
//
//
//  Created by Vladislav Lisianskii on 24.02.2024.
//

import CryptoImageFactory
import MenuBarModels
import SwiftUI

struct MenuPopoverContentView: View {

    let title: String
    let subtitle: String
    @Binding var selectedCoinType: CoinType
    let coinTypes: [CoinType]
    let valueStringForType: (CoinType) -> String
    let checkUpdatesAction: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            VStack {
                Text(title).font(.largeTitle)
                Text(subtitle)
                    .font(.title
                        .bold()
                        .monospacedDigit()
                    )
            }

            Divider()

            Picker("Select Coin", selection: $selectedCoinType) {
                ForEach(coinTypes) { (type: CoinType) in
                    HStack {
                        Image(
                            nsImage: CryptoImageFactory.asset(
                                for: type
                            ).image
                        )
                        .resizable()
                        .scaledToFit()
                        .frame(width: 21, height: 16)

                        Text(type.description).font(.headline)

                        Spacer()

                        Text(valueStringForType(type))
                            .frame(alignment: .trailing)
                            .font(.body.monospacedDigit())

                        Link(destination: type.url) {
                            Image(systemName: "safari")
                        }
                    }
                    .padding(.leading, 8)
                    .tag(type)
                }
            }
            .pickerStyle(RadioGroupPickerStyle())
            .labelsHidden()

            Divider()

            HStack {
                Button("Check for updates") {
                    checkUpdatesAction()
                }

                Button("Quit") {
                    NSApp.terminate(self)
                }
            }
        }
        .padding(
            .init(
                top: 8,
                leading: 16,
                bottom: 16,
                trailing: 16
            )
        )
        .frame(minWidth: 300, idealWidth: 300, maxWidth: 400)
    }
}

#Preview {
    MenuPopoverContentView(
        title: "Bitcoin",
        subtitle: "51204,76 $",
        selectedCoinType: .constant(.bitcoin),
        coinTypes: [.bitcoin, .ethereum],
        valueStringForType: { _ in "51204,76 $" },
        checkUpdatesAction: {}
    )
}
