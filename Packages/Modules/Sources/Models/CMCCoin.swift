//
//  CMCCoin.swift
//  
//
//  Created by Vladislav Lisianskii on 23.05.2022.
//

import Foundation

public struct CMCCoin {
    public let currencyName: String
    public let price: Double
    public let percentChange: Double

    public init(
        currencyName: String,
        price: Double,
        change: Double
    ) {
        self.currencyName = currencyName
        self.price = price
        self.percentChange = change
    }
}
