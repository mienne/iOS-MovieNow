// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "BuildTools",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "BuildTools",
            type: .dynamic,
            targets: ["BuildTools"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.44.1"),
        .package(url: "https://github.com/Realm/SwiftLint", from: "0.39.2"),
        .package(url: "https://github.com/orta/Komondor", from: "1.0.5"),
    ],
    targets: [
        .target(
            name: "BuildTools",
            dependencies: ["SwiftFormat"]
        ),
        .testTarget(
            name: "BuildToolsTests",
            dependencies: ["BuildTools"]
        ),
    ]
)

#if canImport(PackageConfig)
    import PackageConfig

    let config = PackageConfig([
        "komondor": [
            "pre-commit": [
                "git diff --cached --name-only | xargs git diff | md5 > .pre_format_hash",
                "swift run swiftformat \($SRCROOT)",
                "swift run swiftlint --path \($SRCROOT)",
                "git diff --cached --name-only | xargs git diff | md5 > .post_format_hash",
                "diff .pre_format_hash .post_format_hash > /dev/null || { echo \"Staged files modified during commit\" ; rm .pre_format_hash ; rm .post_format_hash ; exit 1; }",
                "rm .pre_format_hash ; rm .post_format_hash",
            ],
        ],
    ]).write()
#endif
