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
            exact: "5.58.1-2718"
        ),
        .package(
            url: "https://github.com/6over6pods/luna-goeyes-sdk-ios",
            exact: "5.46.4-2164"
        ),
        .package(
            url: "https://github.com/6over6pods/luna-dataservices-sdk-ios",
            exact: "8.6.0-132"
        ),
        .package(
            url: "https://github.com/mixpanel/mixpanel-swift",
            .upToNextMinor(from: "4.3.0")
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
            url: "https://glasseson.jfrog.io/artifactory/luna-myrx-sdk-ios-local/6.2.5-1348/MyRxSDK.xcframework.zip",
            checksum: "9f51ec8b16ff85a44bbff0821d26f6a74e4367e249ed8c55ef2770f228b50f38"
        )
    ]
)
