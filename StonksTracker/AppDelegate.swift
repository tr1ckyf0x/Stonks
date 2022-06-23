//
//  AppDelegate.swift
//  StonksTracker
//
//  Created by Vladislav Lisianskii on 06.06.2022.
//  Copyright © 2022 Vladislav Lisianskii. All rights reserved.
//

import AppKit
import StatusItemController
import Swinject
import CoinCapPriceService
import UpdateService
import Log

@main
final class AppDelegate: NSObject, NSApplicationDelegate {

    private var statusItemController: StatusItemControllerInput?
    private var coinCapService: CoinCapPriceServiceProtocol?
    private var updateService: UpdateServiceProtocol?

    private lazy var assemblies: [Assembly] = [
        StatusItemControllerAssembly(),
        CoinCapPriceServiceAssembly(),
        UpdateServiceAssembly(),
        LogAssembly()
    ]

    private lazy var assembler: Assembler = Assembler(assemblies)


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        coinCapService = assembler.resolver.resolve(CoinCapPriceServiceProtocol.self)
        updateService = assembler.resolver.resolve(UpdateServiceProtocol.self)
        setupCoinCapService()

        statusItemController = assembler
            .resolver
            .resolve(
                StatusItemControllerInput.self,
                arguments: NSStatusBar.system,
                assembler
            )
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

// MARK: - Private methods
extension AppDelegate {
    func setupCoinCapService() {
        coinCapService?.connect()
        coinCapService?.startMonitorNetworkConnectivity()
    }
}
