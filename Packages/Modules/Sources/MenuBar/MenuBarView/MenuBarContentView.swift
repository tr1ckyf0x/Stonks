//
//  MenuBarContentView.swift
//
//
//  Created by Vladislav Lisianskii on 24.02.2024.
//

import ProtocolsAndModels
import SwiftUI

struct MenuBarContentView: View {

    let selectedCoinType: CoinType
    let value: String

    var body: some View {
        HStack {
            Image(
                CryptoImageFactory.asset(for: selectedCoinType)
            )
            .resizable()
            .frame(height: 16)

            Text(" \(value)")
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
