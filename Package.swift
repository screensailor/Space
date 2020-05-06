// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Space",
    products: [
        .library(name: "Space", targets: ["Space"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-numerics.git", .upToNextMajor(from: "0.0.5")),
        .package(url: "https://github.com/screensailor/Peek.git", .branch("master")),
        .package(url: "https://github.com/screensailor/TrySwitch.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "Space",
            dependencies: [
                .product(name: "Numerics", package: "swift-numerics"),
                .byName(name: "Peek"),
                .byName(name: "TrySwitch")
            ]
        ),
    ]
)
