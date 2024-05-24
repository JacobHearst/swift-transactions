// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Transactions",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "Transactions",
            targets: ["Transactions"]),
        .library(
            name: "Samples",
            targets: ["Samples"]),
    ],
    dependencies: [
        .package(url: "https://github.com/adamayoung/TMDb", from: "13.0.0")
    ],
    targets: [
        .target(name: "Transactions"),
        .testTarget(
            name: "TransactionsTests",
            dependencies: ["Transactions", "Samples"]
        ),

        .target(
            name: "Samples",
            dependencies: [
                "Transactions",
                .product(name: "TMDb", package: "TMDB")
            ]
        ),
        .testTarget(
            name: "SamplesTests",
            dependencies: [
                "Samples",
            ]
        ),
    ]
)
