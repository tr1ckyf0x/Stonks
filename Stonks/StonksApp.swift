//
//  StonksApp.swift
//  Stonks
//
//  Created by Vladislav Lisianskii on 22.05.2022.
//

import SwiftUI
import KeychainService

@main
struct StonksApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: ContentView.ViewModel(
                    keychainService: KeychainService()
                )
            )
        }
    }
}
