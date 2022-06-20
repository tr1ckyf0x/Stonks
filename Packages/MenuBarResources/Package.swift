// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MenuBarResources",
    defaultLocalization: "en",
    products: [
        .library(
            name: "MenuBarResources",
            targets: ["MenuBarResources"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "MenuBarResources",
            dependencies: []
        )
    ]
)
