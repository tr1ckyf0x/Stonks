//
//  CoinMarketCapRoute.swift
//  
//
//  Created by Vladislav Lisianskii on 23.05.2022.
//

import Foundation
import Moya
import Models

public enum CoinMarketCapRoute {
    case latestQuotes(apiToken: String, symbol: CMCSymbol, fiat: FiatCurrency)
}

extension CoinMarketCapRoute: TargetType {
    public var baseURL: URL {
        URL(string: "https://pro-api.coinmarketcap.com/v1/cryptocurrency")!
    }

    public var path: String {
        switch self {
        case .latestQuotes:
            return "quotes/latest"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .latestQuotes:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case let .latestQuotes(_, symbol, fiat):
            return .requestParameters(
                parameters: [
                    "symbol": symbol.rawValue,
                    "convert": fiat.rawValue
                ],
                encoding: URLEncoding.queryString
            )
        }
    }

    public var headers: [String : String]? {
        let headers: [String: String] = [
            "X-CMC_PRO_API_KEY": apiToken
        ]
        return headers
    }


}

extension CoinMarketCapRoute {
    var apiToken: String {
        switch self {
        case let .latestQuotes(apiToken, _, _):
            return apiToken
        }
    }
}
