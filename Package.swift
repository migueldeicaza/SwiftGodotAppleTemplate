// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "SwiftGodotAppleTemplate",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "SwiftGodotAppleTemplate",
            type: .dynamic,
            targets: ["SwiftGodotAppleTemplate"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/migueldeicaza/SwiftGodot", branch: "barebone-split")
    ],
    targets: [
        .target(
            name: "SwiftGodotAppleTemplate",
            dependencies: [
                .product(name: "SwiftGodotRuntimeStatic", package: "SwiftGodot")
            ],
            swiftSettings: [
                .unsafeFlags([
                    "-Xfrontend", "-internalize-at-link",
                    "-Xfrontend", "-lto=llvm-full",
                    "-Xfrontend", "-conditional-runtime-records"
                ])
            ],
            linkerSettings: [
                .unsafeFlags(["-Xlinker", "-dead_strip"])
            ]
        ),

    ]
)
