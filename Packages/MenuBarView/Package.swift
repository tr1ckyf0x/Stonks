// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MenuBarView",
    defaultLocalization: "en",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "MenuBarView",
            targets: ["MenuBarView"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.3"),
        .package(path: "../CoinCapPriceService"),
        .package(path: "../MenuBarResources"),
        .package(path: "../CryptoImageFactory"),
        .package(path: "../MenuBarModels")
    ],
    targets: [
        .target(
            name: "MenuBarView",
            dependencies: [
                "Swinject",
                .product(name: "CoinCapPriceService", package: "CoinCapPriceService"),
                .product(name: "CoinCapPriceServiceMock", package: "CoinCapPriceService"),
                "MenuBarResources",
                "CryptoImageFactory",
                "MenuBarModels"
            ],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug))
            ]
        )
    ]
)
