//
//  HTTPWriteMethod.swift
//  SwiftRESTKit
//
//  Created by Nikolai Nobadi on 5/12/25.
//

/// Represents supported HTTP methods used for write operations such as PUT, POST, or PATCH.
public enum HTTPWriteMethod: String {
    case put, post, patch

    /// Returns the uppercase string representation of the HTTP method (e.g., "POST").
    public var httpMethod: String {
        rawValue.uppercased()
    }
}
