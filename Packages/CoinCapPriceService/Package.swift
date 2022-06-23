// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoinCapPriceService",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "CoinCapPriceService",
            targets: ["CoinCapPriceService"]
        ),
        .library(
            name: "CoinCapPriceServiceMock",
            targets: ["CoinCapPriceServiceMock"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
        .package(path: "../MenuBarModels"),
        .package(path: "../Log")
    ],
    targets: [
        .target(
            name: "CoinCapPriceService",
            dependencies: [
                "Swinject",
                "MenuBarModels",
                "Log"
            ]
        ),
        .target(
            name: "CoinCapPriceServiceMock",
            dependencies: [
                "CoinCapPriceService",
                "MenuBarModels"
            ],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug))
            ]
        )
    ]
)
