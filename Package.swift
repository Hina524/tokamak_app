// swift-tools-version:5.8
import PackageDescription
let package = Package(
    name: "tokamak_app",
    platforms: [.macOS(.v11), .iOS(.v13)],
    products: [
        .executable(name: "tokamak_app", targets: ["tokamak_app"])
    ],
    dependencies: [
        .package(url: "https://github.com/TokamakUI/Tokamak", from: "0.11.0"),
        .package(url: "https://github.com/swiftwasm/carton", from: "1.1.2")
    ],
    targets: [
        .executableTarget(
            name: "tokamak_app",
            dependencies: [
                "tokamak_appLibrary",
                .product(name: "TokamakShim", package: "Tokamak")
            ]),
        .target(
            name: "tokamak_appLibrary",
            dependencies: []),
        .testTarget(
            name: "tokamak_appLibraryTests",
            dependencies: ["tokamak_appLibrary"]),
    ]
)