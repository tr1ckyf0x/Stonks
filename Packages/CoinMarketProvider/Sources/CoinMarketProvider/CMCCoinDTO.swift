//
//  CMCCoinDTO.swift
//  
//
//  Created by Vladislav Lisianskii on 23.05.2022.
//

import Foundation
import Models

struct CMCCoinDTO {
    let name: String
    let quote: [FiatCurrency: CMCQuoteDTO]
}

extension CMCCoinDTO: Decodable {

    enum CodingKeys: String, CodingKey {
        case name
        case quote
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let quoteContainer = try container.nestedContainer(keyedBy: FiatCurrency.self, forKey: .quote)

        name = try container.decode(String.self, forKey: .name)

        let quotes = try FiatCurrency.allCases.compactMap { (currency: FiatCurrency) -> (FiatCurrency, CMCQuoteDTO)? in
            guard let quote = try quoteContainer.decodeIfPresent(CMCQuoteDTO.self, forKey: currency) else { return nil }
            return (currency, quote)
        }

        quote = Dictionary(uniqueKeysWithValues: quotes)
    }
}
