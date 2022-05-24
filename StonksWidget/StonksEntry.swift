//
//  StonksEntry.swift
//  StonksWidget
//
//  Created by Vladislav Lisianskii on 23.05.2022.
//  Copyright © 2022 Vladislav Lisianskii. All rights reserved.
//

import Foundation
import WidgetKit

struct StonksEntry: TimelineEntry {
    let date: Date
    let currencyName: String
    let price: Double
    let change: PriceChange
}

enum PriceChange {
    case increase(value: Double)
    case decrease(value: Double)

    var value: Double {
        switch self {
        case let .increase(change):
            return change

        case let .decrease(change):
            return change
        }
    }
}
