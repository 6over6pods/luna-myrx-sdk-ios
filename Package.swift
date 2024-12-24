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
            exact: "5.61.0-2696"
        ),
        .package(
            url: "https://github.com/6over6pods/luna-goeyes-sdk-ios",
            exact: "5.46.2-2128"
        ),
        .package(
            url: "https://github.com/6over6pods/luna-dataservices-sdk-ios",
            exact: "8.6.1-157"
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
            url: "https://glasseson.jfrog.io/artifactory/luna-myrx-sdk-ios-local/5.16.2-566/MyRxSDK.xcframework.zip",
            checksum: "e6d20db17c41a259ff8728e80a6d2bbd3206e8d2db7150f3ae84ce5eba474ea8"
        )
    ]
)
