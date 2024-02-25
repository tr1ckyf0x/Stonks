//
//  ContainerProvider.swift
//  StonksTracker
//
//  Created by Vladislav Lisianskii on 25.02.2024.
//  Copyright © 2024 Vladislav Lisianskii. All rights reserved.
//

import AnalyticsService
import CoinCapPriceService
import Foundation
import Log
import Sparkle
import Swinject
import UpdateService

enum ContainerProvider {
    static var `default`: Container = {
        let container = Container()

        // MARK: - Log
        container.register(Log.self) { (_: Resolver) -> Log in
            Log()
        }
        .initCompleted { (_: Resolver, log: Log) in
            log.initializeLoggers()
        }
        .implements(LogProtocol.self)
        .inObjectScope(.container)

        // MARK: - CoinCapPriceService
        container.register(CoinCapPriceService.self) { (resolver: Resolver) -> CoinCapPriceService in
            let log = resolver.resolve(LogProtocol.self)!
            return CoinCapPriceService(log: log)
        }
        .implements(CoinCapPriceServiceProtocol.self)
        .inObjectScope(.weak)

        // MARK: - UpdateService
        container.register(UpdateService.self) { (_: Resolver) -> UpdateService in
            let updaterController = SPUStandardUpdaterController(
                startingUpdater: true,
                updaterDelegate: nil,
                userDriverDelegate: nil
            )
            return UpdateService(updaterController: updaterController)
        }
        .implements(UpdateServiceProtocol.self)
        .inObjectScope(.container)

        // MARK: - AnalyticsService
        container.register(AnalyticsService.self) { (_: Resolver) -> AnalyticsService in
            AnalyticsService()
        }
        .implements(AnalyticsServiceProtocol.self)
        .inObjectScope(.container)

        return container
    }()
}
