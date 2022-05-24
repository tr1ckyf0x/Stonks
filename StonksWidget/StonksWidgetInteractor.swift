//
//  StonksWidgetInteractor.swift
//  StonksWidget
//
//  Created by Vladislav Lisianskii on 23.05.2022.
//  Copyright © 2022 Vladislav Lisianskii. All rights reserved.
//

import Foundation
import CoinMarketProvider
import Models
import STNetworking
import KeychainService

protocol StonksWidgetInteractorProtocol {
    func fetchStonksEntry() async throws -> StonksEntry
}

final class StonksWidgetInteractor {
    let coinMarketProvider: CoinMarketProviderProtocol
    let keychainService: KeychainServiceProtocol

    init(
        coinMarketProvider: CoinMarketProviderProtocol,
        keychainService: KeychainServiceProtocol
    ) {
        self.coinMarketProvider = coinMarketProvider
        self.keychainService = keychainService
    }
}

// MARK: - StonksWidgetInteractorProtocol
extension StonksWidgetInteractor: StonksWidgetInteractorProtocol {
    func fetchStonksEntry() async throws -> StonksEntry {
        let apiTokenData = try keychainService.readValue(for: .cmcAPIToken)
        guard let apiToken = String(data: apiTokenData, encoding: .utf8) else {
            throw Error.noAPIToken
        }

        let cmcCoin = try await coinMarketProvider.fetchQuote(for: .bitcoin, fiat: .usd, apiToken: apiToken)
        let stonksEntry = StonksEntryBuilder.build(cmcCoin: cmcCoin)
        return stonksEntry
    }
}

extension StonksWidgetInteractor {
    enum Error: Swift.Error {
        case noAPIToken
    }
}
