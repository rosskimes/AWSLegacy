// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AWSLegacy",
	platforms: [.iOS(.v14), .macCatalyst(.v14), .tvOS(.v14), .watchOS(.v7)],
    products: [
        .library(name: "AWSCore", targets: ["AWSCore"]),
		.library(name: "AWSCognitoIdentityProvider", targets: ["AWSCognitoIdentityProvider"])
    ],
    dependencies: [],
    targets: [
        .target(name: "AWSCore", dependencies: []),
		.target(name: "AWSCognitoIdentityProvider", dependencies: ["AWSCore"])
    ]
)
