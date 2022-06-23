// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CryptoImageFactory",
    products: [
        .library(
            name: "CryptoImageFactory",
            targets: ["CryptoImageFactory"]
        )
    ],
    dependencies: [
        .package(path: "../MenuBarResources"),
        .package(path: "../Models")
    ],
    targets: [
        .target(
            name: "CryptoImageFactory",
            dependencies: [
                "MenuBarResources",
                "Models"
            ]
        )
    ]
)
