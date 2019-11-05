// swift-tools-version:5.1
// Managed by ice

import PackageDescription

let package = Package(
    name: "rxpl",
    products: [
        .executable(name: "rxpl", targets: ["rxpl"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", from: "5.0.1"),
        .package(url: "https://github.com/jakeheis/SwiftCLI", from: "5.3.3"),
    ],
    targets: [
        .target(name: "rxpl", dependencies: ["RxSwift", "RxRelay", "SwiftCLI"]),
    ]
)
