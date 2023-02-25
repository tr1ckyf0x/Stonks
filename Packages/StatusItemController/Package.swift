// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StatusItemController",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "StatusItemController",
            targets: ["StatusItemController"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.3"),
        .package(path: "../MenuBarView"),
        .package(path: "../MenuPopoverView")
    ],
    targets: [
        .target(
            name: "StatusItemController",
            dependencies: [
                "Swinject",
                "MenuBarView",
                "MenuPopoverView"
            ]
        )
    ]
)
