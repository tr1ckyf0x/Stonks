//
//  CMCCoinBuilder.swift
//  
//
//  Created by Vladislav Lisianskii on 23.05.2022.
//

import Foundation
import Models

enum CMCCoinBuilder {
    static func build(raw: CMCCoinDTO, fiat: FiatCurrency) -> CMCCoin? {
        guard let quote = raw.quote[fiat] else { return nil }
        return CMCCoin(
            currencyName: raw.name,
            price: quote.price,
            change: quote.percentChange24h
        )
    }
}
