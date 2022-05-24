//
//  CoinMarketProvider.swift
//  CoinMarketProvider
//
//  Created by Vladislav Lisianskii on 23.05.2022.
//  Copyright © 2022 Vladislav Lisianskii. All rights reserved.
//

import STNetworking
import Moya
import Models

public protocol CoinMarketProviderProtocol {
    func fetchQuote(for symbol: CMCSymbol, fiat: FiatCurrency, apiToken: String) async throws -> CMCCoin
}

public final class CoinMarketProvider {

    private let moyaProvider: MoyaProvider<CoinMarketCapRoute>

    public init(moyaProvider: MoyaProvider<CoinMarketCapRoute>) {
        self.moyaProvider = moyaProvider
    }
}

extension CoinMarketProvider: CoinMarketProviderProtocol {
    public func fetchQuote(for symbol: CMCSymbol, fiat: FiatCurrency, apiToken: String) async throws -> CMCCoin {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<CMCCoin, Error>) in
            moyaProvider.request(.latestQuotes(apiToken: apiToken, symbol: symbol, fiat: fiat)) { result in
                do {
                    switch result {
                    case let .success(response):
                        let fetchQuoteResponse = try response.map(FetchQuoteResponse.self)
                        guard let cmcCoinDTO = fetchQuoteResponse.data.first?.value,
                              let cmcCoin = CMCCoinBuilder.build(raw: cmcCoinDTO, fiat: fiat)
                        else {
                            continuation.resume(throwing: CoinMarketProviderError.mapFailure)
                            return
                        }

                        continuation.resume(returning: cmcCoin)

                    case let .failure(error):
                        continuation.resume(throwing: error)
                    }
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

enum CoinMarketProviderError: Error {
    case mapFailure
}
