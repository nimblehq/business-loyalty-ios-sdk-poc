// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NimbleLoyalty",
    products: [
        .library(
            name: "NimbleLoyalty",
            targets: ["NimbleLoyalty"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "3.0.0")
    ],
    targets: [
        .target(
            name: "NimbleLoyalty",
            dependencies: ["Moya", "KeychainAccess"],
            path: "Sources")
    ]
)
