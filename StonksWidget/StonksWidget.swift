//
//  StonksWidget.swift
//  StonksWidget
//
//  Created by Vladislav Lisianskii on 22.05.2022.
//  Copyright © 2022 Vladislav Lisianskii. All rights reserved.
//

import WidgetKit
import SwiftUI
import CoinMarketProvider
import Moya
import STNetworking
import KeychainService

@main
struct StonksWidget: Widget {
    let kind: String = "widget"

    var body: some WidgetConfiguration {
        let moyaProvider = MoyaProvider<CoinMarketCapRoute>()
        let coinMarketProvider = CoinMarketProvider(
            moyaProvider: moyaProvider
        )
        let keychainService = KeychainService()

        let interactor = StonksWidgetInteractor(
            coinMarketProvider: coinMarketProvider,
            keychainService: keychainService
        )
        return StaticConfiguration(kind: kind, provider: Provider(stonksWidgetInteractor: interactor)) { entry in
            StonksWidgetView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
