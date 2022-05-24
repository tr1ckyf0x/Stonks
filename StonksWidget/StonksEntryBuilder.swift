//
//  StonksEntryBuilder.swift
//  StonksWidget
//
//  Created by Vladislav Lisianskii on 23.05.2022.
//  Copyright © 2022 Vladislav Lisianskii. All rights reserved.
//

import Foundation
import Models

enum StonksEntryBuilder {
    static func build(cmcCoin: CMCCoin) -> StonksEntry {
        let change: PriceChange
        if cmcCoin.percentChange >= 0 {
            change = .increase(value: cmcCoin.percentChange)
        } else {
            change = .decrease(value: cmcCoin.percentChange)
        }

        return StonksEntry(
            date: Date(),
            currencyName: cmcCoin.currencyName,
            price: cmcCoin.price,
            change: change
        )
    }
}
