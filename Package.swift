// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BogusApp-Common-UIComponents",
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .tvOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "BogusApp-Common-UIComponents-iOS", targets: ["BogusApp-Common-UIComponents-iOS"]),
        .library(name: "BogusApp-Common-UIComponents-tvOS", targets: ["BogusApp-Common-UIComponents-tvOS"])
    ],
    dependencies: [
        .package(name: "BogusApp-Common-Models", url: "../BogusApp-Common-Models", .branch("master")),
        .package(name: "BogusApp-Common-Utils", url: "../BogusApp-Common-Utils", .branch("master")),
        .package(name: "BogusApp-Common-Networking", url: "../BogusApp-Common-Networking", .branch("master")),
        .package(name: "BogusApp-Features-TargetsList", url: "../../Features/BogusApp-Features-TargetsList", .branch("master")),
        .package(name: "BogusApp-Features-ChannelsList", url: "../../Features/BogusApp-Features-ChannelsList", .branch("master")),
        .package(name: "BogusApp-Features-PlansList", url: "../../Features/BogusApp-Features-PlansList", .branch("master")),
        .package(name: "BogusApp-Features-CampaignReview", url: "../../Features/BogusApp-Features-CampaignReview", .branch("master"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "BogusApp-Common-UIComponents",
            dependencies: [
                .product(name: "BogusApp-Common-Models", package: "BogusApp-Common-Models"),
                .product(name: "BogusApp-Common-Utils", package: "BogusApp-Common-Utils"),
                .product(name: "BogusApp-Common-Networking", package: "BogusApp-Common-Networking"),
                .product(name: "BogusApp-Features-TargetsList", package: "BogusApp-Features-TargetsList"),
                .product(name: "BogusApp-Features-ChannelsList", package: "BogusApp-Features-ChannelsList"),
                .product(name: "BogusApp-Features-PlansList", package: "BogusApp-Features-PlansList"),
                .product(name: "BogusApp-Features-CampaignReview", package: "BogusApp-Features-CampaignReview")
            ]),
        .target(
            name: "BogusApp-Common-UIComponents-iOS",
            dependencies: ["BogusApp-Common-UIComponents"],
            resources: [.copy("TargetsListViewController.storyboard")]),
        .target(
            name: "BogusApp-Common-UIComponents-tvOS",
            dependencies: ["BogusApp-Common-UIComponents"]),
        .testTarget(
            name: "BogusApp-Common-UIComponentsTests",
            dependencies: ["BogusApp-Common-UIComponents"]),
    ]
)
