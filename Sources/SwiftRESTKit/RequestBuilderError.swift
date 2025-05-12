//
//  RequestBuilderError.swift
//  SwiftRESTKit
//
//  Created by Nikolai Nobadi on 5/12/25.
//

/// Errors that can occur during the construction of a `URLRequest`.
public enum RequestBuilderError: Error {
    /// Indicates that a URL could not be formed from the given components.
    case invalidURL
}
