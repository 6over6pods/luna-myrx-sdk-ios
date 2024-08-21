// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyRxSDK",
    defaultLocalization: "en-US",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MyRxSDK",
            targets: ["MyRxSDKWrapper"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(
            url: "https://github.com/6over6pods/luna-glasseson-sdk-ios",
            exact: "5.54.1-2526"
        ),
        .package(
            url: "https://github.com/6over6pods/luna-goeyes-sdk-ios",
            exact: "5.45.8-1511"
        ),
        .package(
            url: "https://github.com/6over6pods/luna-dataservices-sdk-ios",
            exact: "8.5.0-107"
        ),
        .package(
            url: "https://github.com/mixpanel/mixpanel-swift",
            .upToNextMajor(from: "4.1.2")
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MyRxSDKWrapper",
            dependencies: [.product(name: "Mixpanel", package: "mixpanel-swift"),
                           .product(name: "GlassesOnSDK", package: "luna-glasseson-sdk-ios"),
                           .product(name: "GoEyesSDK", package: "luna-goeyes-sdk-ios"),
                           .product(name: "PHISDK", package: "luna-dataservices-sdk-ios"),
                           .target(name: "MyRxSDK")]
        ),
        .binaryTarget(
            name: "MyRxSDK",
            url: "https://glasseson.jfrog.io/artifactory/luna-myrx-sdk-ios-local/5.10.1-390/MyRxSDK.xcframework.zip",
            checksum: "939c54a2478bcc170783101fbdd056b59efb5c62c339cc84a69f30f30d30c4ce"
        )
    ]
)
