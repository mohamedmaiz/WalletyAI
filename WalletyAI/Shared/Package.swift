// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Shared",
    platforms: [.iOS(.v18)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Shared",
            targets: ["Shared"]
        ),
    ],
    dependencies: [
        // Swift Collections by Apple: https://github.com/apple/swift-collections
        .package(url: "https://github.com/apple/swift-collections", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Shared",
            dependencies: [
                // Example: Add Swift Collections package product as a dependency
                .product(name: "Collections", package: "swift-collections")
            ]
        ),
        .testTarget(
            name: "SharedTests",
            dependencies: ["Shared"]
        ),
    ]
)
