// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SharedResources",
    products: [
        .library(
            name: "SharedResources",
            targets: ["SharedResources"]
        )
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SharedResources",
            dependencies: []
        )
    ]
)
