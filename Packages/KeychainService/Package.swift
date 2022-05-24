// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KeychainService",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "KeychainService",
            targets: ["KeychainService"]
        )
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "KeychainService",
            dependencies: []
        )
    ]
)
