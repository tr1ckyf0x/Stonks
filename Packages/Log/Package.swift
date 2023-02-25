// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Log",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "Log",
            targets: ["Log"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/CocoaLumberjack/CocoaLumberjack", from: "3.8.0"),
        .package(url: "https://github.com/Swinject/Swinject", from: "2.8.3")
    ],
    targets: [
        .target(
            name: "Log",
            dependencies: [
                .product(name: "CocoaLumberjackSwift", package: "CocoaLumberjack"),
                "Swinject"
            ]
        )
    ]
)
