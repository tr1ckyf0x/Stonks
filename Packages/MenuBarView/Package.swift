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
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
        .package(path: "../Models"),
        .package(path: "../CoinCapPriceService"),
        .package(path: "../MenuBarResources")
    ],
    targets: [
        .target(
            name: "MenuBarView",
            dependencies: [
                "Swinject",
                "Models",
                .product(name: "CoinCapPriceService", package: "CoinCapPriceService"),
                .product(name: "CoinCapPriceServiceMock", package: "CoinCapPriceService"),
                "MenuBarResources"
            ],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug))
            ]
        )
    ]
)
