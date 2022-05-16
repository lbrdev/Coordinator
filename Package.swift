// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Coordinator",
    platforms: [
        .macOS(.v11),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v5)
    ],
    products: [
        .library(
            name: "Coordinator",
            targets: ["Coordinator"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Coordinator",
            dependencies: []
        ),
        .testTarget(
            name: "CoordinatorTests",
            dependencies: ["Coordinator"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
