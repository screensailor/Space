// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Space",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "Space", targets: ["Space"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-numerics.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "Space",
            dependencies: [
                .product(name: "Numerics", package: "swift-numerics"),
            ]
        ),
    ]
)
