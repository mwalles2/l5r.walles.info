// swift-tools-version:5.2
import PackageDescription

let package = Package(
	name: "info.walles.l5r",
	platforms: [
		.macOS(.v10_15)
	],
	dependencies: [
		// 💧 A server-side Swift web framework.
		.package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
		.package(url: "https://github.com/vapor/leaf.git", from: "4.0.0-rc"),
		.package(url: "git@github.com:mwalles2/RollAndKeepSystem.git", from: "1.0.0-alpha")
	],
	targets: [
		.target(
			name: "App",
			dependencies: [
				.product(name: "Vapor", package: "vapor"),
				.product(name: "Leaf", package: "leaf"),
				.product(name: "RollAndKeepSystem", package: "RollAndKeepSystem")
			],
			swiftSettings: [
				// Enable better optimizations when building in Release configuration. Despite the use of
				// the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
				// builds. See <https://github.com/swift-server/guides#building-for-production> for details.
				.unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
			]
		),
		.target(name: "info.walles.l5r", dependencies: [.target(name: "App")]),
		.testTarget(name: "AppTests", dependencies: [
			.target(name: "App"),
			.product(name: "XCTVapor", package: "vapor"),
		])
	]
)
