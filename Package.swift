// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AWSLegacy",
	platforms: [.iOS(.v14), .macCatalyst(.v14), .tvOS(.v14), .watchOS(.v7)],
    products: [
        .library(name: "AWSCoreLegacy", targets: ["AWSCoreLegacy"]),
		.library(name: "AWSCognitoIdentityProviderLegacy", targets: ["AWSCognitoIdentityProviderLegacy"])
    ],
    dependencies: [],
    targets: [
        .target(name: "AWSCoreLegacy", dependencies: []),
		.target(name: "AWSCognitoIdentityProviderLegacy", dependencies: ["AWSCoreLegacy"])
    ]
)
