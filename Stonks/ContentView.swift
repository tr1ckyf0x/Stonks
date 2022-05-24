//
//  ContentView.swift
//  Stonks
//
//  Created by Vladislav Lisianskii on 22.05.2022.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        HStack {
            Text(L10n.App.APIToken.title)
                .fixedSize()

            SecureField(
                L10n.App.APIToken.placeholder,
                text: $viewModel.apiToken
            )
            .frame(width: 250)
            
            Button(L10n.App.APIToken.save) {
                viewModel.saveApiToken()
            }
            .fixedSize()
        }
        .padding()
        .onAppear {
            viewModel.loadApiToken()
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(
                viewModel: ContentView.ViewModel(
                    keychainService: KeychainServiceMockHasData()
                )
            )
            ContentView(
                viewModel: ContentView.ViewModel(
                    keychainService: KeychainServiceMockNoData()
                )
            )
        }
    }
}
#endif
