// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AnalyticsService",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "AnalyticsService",
            targets: ["AnalyticsService"]
        ),
        .library(
            name: "AnalyticsServiceMock",
            targets: ["AnalyticsServiceMock"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.3"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "10.7.0")
    ],
    targets: [
        .target(
            name: "AnalyticsService",
            dependencies: [
                "Swinject",
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
            ]
        ),
        .target(
            name: "AnalyticsServiceMock",
            dependencies: [
                "AnalyticsService"
            ],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug))
            ]
        )
    ]
)
