//
//  StonksApp.swift
//  StonksTracker
//
//  Created by Vladislav Lisianskii on 25.02.2024.
//  Copyright © 2024 Vladislav Lisianskii. All rights reserved.
//

import FirebaseCore
import SwiftUI
import Swinject

@main
struct StonksApp: App {

    private let analyticsService: AnalyticsServiceProtocol
    private let coinCapService: CoinCapPriceServiceProtocol
    private let updateService: UpdateServiceProtocol

    private let container: Container

    init() {
        FirebaseApp.configure()

        container = ContainerProvider.default

        analyticsService = container.resolve(AnalyticsServiceProtocol.self)!
        coinCapService = container.resolve(CoinCapPriceServiceProtocol.self)!
        updateService = container.resolve(UpdateServiceProtocol.self)!

        setupCoinCapService()

        UserDefaults.standard.register(
            defaults: ["NSApplicationCrashOnExceptions": true]
        )

        analyticsService.logEvent(.appOpen)
    }

    var body: some Scene {
        MenuBarExtra {
            MenuPopoverView(
                viewModel: MenuPopoverViewModel(
                    coinCapService: coinCapService,
                    updateService: updateService,
                    analyticsService: analyticsService
                )
            )
        } label: {
            MenuBarView(
                viewModel: MenuBarViewModel(service: coinCapService)
            )
        }
        .menuBarExtraStyle(.window)
    }
}

// MARK: - Private

extension StonksApp {
    func setupCoinCapService() {
        coinCapService.connect()
        coinCapService.startMonitorNetworkConnectivity()
    }
}
