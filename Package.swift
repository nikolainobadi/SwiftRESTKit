// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftRESTKit",
    products: [
        .library(
            name: "SwiftRESTKit",
            targets: ["SwiftRESTKit"]),
    ],
    targets: [
        .target(
            name: "SwiftRESTKit"),
        .testTarget(
            name: "SwiftRESTKitTests",
            dependencies: [
                "SwiftRESTKit"
            ]
        )
    ]
)
