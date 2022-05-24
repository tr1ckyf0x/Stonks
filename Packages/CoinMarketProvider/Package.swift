// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoinMarketProvider",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "CoinMarketProvider",
            targets: ["CoinMarketProvider"]
        )
    ],
    dependencies: [
        .package(path: "../STNetworking"),
        .package(path: "../Models")
    ],
    targets: [
        .target(
            name: "CoinMarketProvider",
            dependencies: [
                "STNetworking",
                "Models"
            ]
        )
    ]
)
