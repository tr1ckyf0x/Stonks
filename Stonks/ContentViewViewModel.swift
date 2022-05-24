//
//  ContentViewViewModel.swift
//  Stonks
//
//  Created by Vladislav Lisianskii on 24.05.2022.
//  Copyright © 2022 Vladislav Lisianskii. All rights reserved.
//

import Foundation
import KeychainService

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var apiToken: String = ""

        private let keychainService: KeychainServiceProtocol

        init(keychainService: KeychainServiceProtocol) {
            self.keychainService = keychainService
        }

        func loadApiToken() {
            do {
                let tokenData = try keychainService.readValue(for: .cmcAPIToken)
                guard let token = String(data: tokenData, encoding: .utf8) else { return }
                apiToken = token
            } catch {
                print(error)
            }
        }

        func saveApiToken() {
            saveToken(apiToken)
        }
    }
}

extension ContentView.ViewModel {
    private func saveToken(_ token: String) {
        if token.isEmpty {
            removeToken()
            return
        }
        do {
            guard let data = token.data(using: .utf8) else { return }
            try keychainService.saveValue(data, for: .cmcAPIToken)
        } catch {
            print(error)
        }
    }

    private func removeToken() {
        do {
            try keychainService.removeValue(for: .cmcAPIToken)
        } catch {
            print(error)
        }
    }
}
