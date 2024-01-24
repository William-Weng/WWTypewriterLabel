// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWTypewriterLabel",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "WWTypewriterLabel", targets: ["WWTypewriterLabel"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "WWTypewriterLabel", dependencies: []),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
