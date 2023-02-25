// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MenuPopoverView",
    defaultLocalization: "en",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "MenuPopoverView",
            targets: ["MenuPopoverView"]
        )
    ],
    dependencies: [
        .package(path: "../CoinCapPriceService"),
        .package(path: "../MenuBarResources"),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.3"),
        .package(path: "../UpdateService"),
        .package(path: "../CryptoImageFactory"),
        .package(path: "../MenuBarModels"),
        .package(path: "../AnalyticsService")
    ],
    targets: [
        .target(
            name: "MenuPopoverView",
            dependencies: [
                .product(name: "CoinCapPriceService", package: "CoinCapPriceService"),
                .product(name: "CoinCapPriceServiceMock", package: "CoinCapPriceService"),
                "MenuBarResources",
                "Swinject",
                .product(name: "UpdateService", package: "UpdateService"),
                .product(name: "UpdateServiceMock", package: "UpdateService"),
                "CryptoImageFactory",
                "MenuBarModels",
                .product(name: "AnalyticsService", package: "AnalyticsService"),
                .product(name: "AnalyticsServiceMock", package: "AnalyticsService")
            ],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug))
            ]
        )
    ]
)
