// swift-tools-version:6.2
import PackageDescription

let package = Package(
    name: "KissXML",
    platforms: [
        .macOS(.v15),
        .iOS(.v18),
        .tvOS(.v18),
        .watchOS(.v11)
    ],
    products: [
        .library(
            name: "KissXML",
			type: .dynamic,
            targets: ["KissXML"]
        )
    ],
    targets: [
        .target(
            name: "KissXML",
            path: "KissXML",
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("Additions"),
                .headerSearchPath("Categories"),
                .headerSearchPath("Private")
            ],
            linkerSettings: [
                .linkedLibrary("xml2")
            ]
        ),
        .testTarget(
            name: "KissXMLTests",
            dependencies: ["KissXML"],
            path: "Tests/Shared",
            sources: [
                "DDAssertionHandler.m",
                "KissXMLAssertionTests.m",
                "KissXMLTests.m"
            ]
        ),
        .testTarget(
            name: "KissXMLSwiftTests",
            dependencies: ["KissXML"],
            path: "Tests/Shared",
            sources: [
                "KissXMLSwiftTests.swift"
            ]
        )
    ]
)
