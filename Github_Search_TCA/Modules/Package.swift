// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Modules",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "GCommon", targets: ["GCommon"]),
    .library(name: "GDTO", targets: ["GDTO"]),
    .library(name: "GEntities", targets: ["GEntities"]),
    .library(name: "GInfra", targets: ["GInfra"]),
    .library(name: "GRepositories", targets: ["GRepositories"]),
    .library(name: "GSearchCell", targets: ["GSearchCell"]),
    .library(name: "GSearchDetail", targets: ["GSearchDetail"]),
    .library(name: "GSearchMain", targets: ["GSearchMain"]),
    .library(name: "GDIContainer", targets: ["GDIContainer"])
  ],
  dependencies: [
    .package(url: "git@github.com:pointfreeco/swift-composable-architecture.git", from: "0.34.0"),
    .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0"))
  ],
  targets: [
    .target(
      name: "GCommon",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "GEntities"
      ]
    ),
    .target(
      name: "GDTO",
      dependencies: [
        "GEntities"
      ]
    ),
    .target(
      name: "GEntities",
      dependencies: []
    ),
    .target(
      name: "GInfra",
      dependencies: [
        .product(name: "CombineMoya", package: "Moya"),
      ]
    ),
    .target(
      name: "GRepositories",
      dependencies: [
        "GEntities",
        "GInfra",
        "GDTO",
        "GCommon"
      ]
    ),
    .target(
      name: "GSearchCell",
      dependencies: [
        "GEntities",
        "GRepositories",
        "GSearchDetail"
      ]
    ),
    .target(
      name: "GSearchDetail",
      dependencies: [
        "GEntities"
      ]
    ),
    .target(
      name: "GSearchMain",
      dependencies: [
        "GEntities",
        "GRepositories",
        "GSearchCell"
      ]
    ),
    .target(
      name: "GDIContainer",
      dependencies: [
        "GRepositories",
        "GInfra",
        "GSearchCell",
        "GSearchMain",
        "GCommon"
      ]
    ),
  ]
)
