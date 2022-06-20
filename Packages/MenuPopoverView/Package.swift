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
        .package(path: "../Models"),
        .package(path: "../CoinCapPriceService"),
        .package(path: "../MenuBarResources"),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
        .package(path: "../UpdateService")
    ],
    targets: [
        .target(
            name: "MenuPopoverView",
            dependencies: [
                "Models",
                .product(name: "CoinCapPriceService", package: "CoinCapPriceService"),
                .product(name: "CoinCapPriceServiceMock", package: "CoinCapPriceService"),
                "MenuBarResources",
                "Swinject",
                .product(name: "UpdateService", package: "UpdateService"),
                .product(name: "UpdateServiceMock", package: "UpdateService")
            ],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug))
            ]
        )
    ]
)
