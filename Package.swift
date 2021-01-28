// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "rxpl",
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.0.0"),
        .package(url: "https://github.com/jakeheis/SwiftCLI", from: "6.0.0"),
    ],
    targets: [
        .target(
            name: "rxpl",
            dependencies: [
                .product(name: "RxRelay", package: "RxSwift"),
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "SwiftCLI", package: "SwiftCLI"),
            ]),
    ]
)
