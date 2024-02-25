// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    defaultLocalization: "en",
    platforms: [.macOS(.v13)],
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
            name: "ProtocolsAndModels",
            targets: ["ProtocolsAndModels"]
        ),
        .library(
            name: "UpdateService",
            targets: ["UpdateService"]
        ),
        .library(
            name: "MenuBar",
            targets: ["MenuBar"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "10.21.0"),
        .package(url: "https://github.com/CocoaLumberjack/CocoaLumberjack", from: "3.8.4"),
        .package(url: "https://github.com/sparkle-project/Sparkle", from: "2.5.2")
    ],
    targets: [
        .target(
            name: "AnalyticsService",
            dependencies: [
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
            ]
        ),
        .target(
            name: "CoinCapPriceService",
            dependencies: [
                "ProtocolsAndModels",
                "Log"
            ]
        ),
        .target(
            name: "Log",
            dependencies: [
                .product(name: "CocoaLumberjackSwift", package: "CocoaLumberjack")
            ]
        ),
        .target(
            name: "ProtocolsAndModels"
        ),
        .target(
            name: "UpdateService",
            dependencies: [
                "Sparkle"
            ]
        ),
        .target(
            name: "MenuBar",
            dependencies: [
                "CoinCapPriceService",
                "ProtocolsAndModels",
                "UpdateService",
                "AnalyticsService"
            ]
        )
    ]
)
