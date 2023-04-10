// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UpdateService",
    platforms: [.macOS(.v11)],
    products: [
        .library(
            name: "UpdateService",
            targets: ["UpdateService"]
        ),
        .library(
            name: "UpdateServiceMock",
            targets: ["UpdateServiceMock"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject", from: "2.8.3"),
        .package(url: "https://github.com/sparkle-project/Sparkle", from: "2.4.0"),
    ],
    targets: [
        .target(
            name: "UpdateService",
            dependencies: [
                "Swinject",
                "Sparkle"
            ]
        ),
        .target(
            name: "UpdateServiceMock",
            dependencies: [
                "UpdateService"
            ],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug))
            ]
        )
    ]
)
