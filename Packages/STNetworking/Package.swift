// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "STNetworking",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "STNetworking",
            targets: ["STNetworking"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0")),
        .package(path: "../Models")
    ],
    targets: [
        .target(
            name: "STNetworking",
            dependencies: [
                "Moya",
                "Models"
            ]
        )
    ]
)
