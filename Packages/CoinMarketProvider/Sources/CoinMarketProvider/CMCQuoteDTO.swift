//
//  CMCQuoteDTO.swift
//  
//
//  Created by Vladislav Lisianskii on 23.05.2022.
//

import Foundation

struct CMCQuoteDTO: Decodable {
    let price: Double
    let percentChange24h: Double

    enum CodingKeys: String, CodingKey {
        case price
        case percentChange24h = "percent_change_24h"
    }
}
