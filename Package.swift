// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "iOSBKMExpressSDK",
  platforms: [
    .iOS(.v12)
  ],
  products: [
    .library(
      name: "BKMExpressSDK",
      targets: ["BKMExpressSDK"]
    )
  ],
  targets: [
    .binaryTarget(
      name: "BKMExpressSDK",
      path: "BKMExpressSDK.xcframework"
    )
  ]
)
