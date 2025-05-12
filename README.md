# SwiftRESTKit

![Swift](https://badgen.net/badge/swift/6.0%2B/purple)
[![Platform](https://img.shields.io/badge/platforms-macOS%20%7C%20iOS-blue)]()
![License](https://img.shields.io/badge/license-MIT-lightgrey)

## Overview

**SwiftRESTKit** is a lightweight Swift package for building type-safe `URLRequest` objects using a composable and testable API. It simplifies RESTful request construction for GET, DELETE, POST, PUT, and PATCH operations, with support for custom headers, query parameters, and JSON body encoding.


## Features

- Build RESTful `URLRequest`s with ease
- Strongly-typed header support (`Accept`, `Content-Type`, `Authorization`, and custom)
- Support for query parameters, JSON-encoded bodies, timeout intervals, and cache policies


## Installation

To use **SwiftRESTKit** in your SwiftPM project, add the following to your `Package.swift`:

```swift
.package(url: "https://github.com/nikolainobadi/SwiftRESTKit", from: "1.0.0")
```

Then add `"SwiftRESTKit"` as a dependency to your target:

```swift
.product(name: "SwiftRESTKit", package: "SwiftRESTKit")
```

## Usage

### Build a GET request:

```swift
let request = try RestRequestBuilder.buildGET(
    baseURL: URL(string: "https://example.com")!,
    path: "search",
    query: ["q": "Swift"],
    headers: HTTPRequestHeaders(authorization: "Bearer token")
)
```

### Build a POST request with JSON body:

```swift
let request = try RestRequestBuilder.buildWrite(
    baseURL: URL(string: "https://example.com")!,
    path: "users",
    method: .post,
    body: ["name": "Jane Doe"],
    headers: HTTPRequestHeaders(contentType: .json)
)
```

## Architecture Notes

The core logic is encapsulated in:

- `RestRequestBuilder`: Public API for request construction
- `HTTPRequestHeaders`: Struct to encapsulate standard and custom headers
- `HTTPWriteMethod`: Enum for POST, PUT, and PATCH
- `RequestBuilderError`: Custom error enum for URL formation issues

Private helpers are used internally to ensure testability and reusability of components.


## About This Project

**SwiftRESTKit** was created to reduce boilerplate in network layer setup across iOS/macOS Swift projects. It emphasizes readability, testability, and Swift-native design patterns.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request on [GitHub](https://github.com/nikolainobadi/SwiftRESTKit).

## License

This project is licensed under the MIT License. See [LICENSE](https://github.com/nikolainobadi/SwiftRESTKit/blob/main/LICENSE) for details.
