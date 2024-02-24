//
//  MenuBarContentView.swift
//
//
//  Created by Vladislav Lisianskii on 24.02.2024.
//

import CryptoImageFactory
import MenuBarModels
import SwiftUI

struct MenuBarContentView: View {

    let selectedCoinType: CoinType
    let value: String

    var body: some View {
        HStack(spacing: 8) {
            Image(
                nsImage: CryptoImageFactory.asset(
                    for: selectedCoinType
                ).image
            )
            .resizable()
            .frame(height: 16)

            Text(value)
                .font(.title3.monospacedDigit())

        }
        .padding([.leading, .trailing], 8)
        .fixedSize()
    }
}

#Preview {
    MenuBarContentView(
        selectedCoinType: .bitcoin,
        value: "51150,12 $"
    )
}
