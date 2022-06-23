// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MenuBarModels",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "MenuBarModels",
            targets: ["MenuBarModels"]
        )
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "MenuBarModels",
            dependencies: []
        )
    ]
)
