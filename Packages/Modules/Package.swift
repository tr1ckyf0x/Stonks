// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    defaultLocalization: "en",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "AnalyticsService",
            targets: ["AnalyticsService"]
        ),
        .library(
            name: "CoinCapPriceService",
            targets: ["CoinCapPriceService"]
        ),
        .library(
            name: "Log",
            targets: ["Log"]
        ),
        .library(
            name: "MenuBarModels",
            targets: ["MenuBarModels"]
        ),
        .library(
            name: "UpdateService",
            targets: ["UpdateService"]
        ),
        .library(
            name: "StatusItemController",
            targets: ["StatusItemController"]
        ),
        .library(
            name: "MenuBar",
            targets: ["MenuBar"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.4"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "10.21.0"),
        .package(url: "https://github.com/CocoaLumberjack/CocoaLumberjack", from: "3.8.4"),
        .package(url: "https://github.com/sparkle-project/Sparkle", from: "2.5.2")
    ],
    targets: [
        .target(
            name: "AnalyticsService",
            dependencies: [
                "Swinject",
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
            ]
        ),
        .target(
            name: "CoinCapPriceService",
            dependencies: [
                "Swinject",
                "MenuBarModels",
                "Log"
            ]
        ),
        .target(
            name: "Log",
            dependencies: [
                .product(name: "CocoaLumberjackSwift", package: "CocoaLumberjack"),
                "Swinject"
            ]
        ),
        .target(
            name: "MenuBarModels"
        ),
        .target(
            name: "UpdateService",
            dependencies: [
                "Swinject",
                "Sparkle"
            ]
        ),
        .target(
            name: "StatusItemController",
            dependencies: [
                "Swinject",
                "MenuBar",
            ]
        ),
        .target(
            name: "MenuBar",
            dependencies: [
                "Swinject",
                "CoinCapPriceService",
                "MenuBarModels",
                "UpdateService",
                "AnalyticsService"
            ]
        )
    ]
)
