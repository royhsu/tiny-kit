// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "TinyKit",
    dependencies: [
      .Package(url: "https://github.com/royhsu/tiny-core.git", Version(0, 1, 0, prereleaseIdentifiers: ["beta", "1"]))
    ]
)
