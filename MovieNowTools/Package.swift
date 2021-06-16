// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "MovieNowTools",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "MovieNowTools",
            type: .dynamic,
            targets: ["MovieNowTools"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.2.0")
    ],
    targets: [
        .target(
            name: "MovieNowTools",
            dependencies: [
                .product(name: "Logging", package: "swift-log")
            ]
        ),
        .testTarget(
            name: "MovieNowToolsTests",
            dependencies: ["MovieNowTools"]
        )
    ]
)
