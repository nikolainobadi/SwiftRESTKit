//
//  HTTPRequestHeaders.swift
//  SwiftRESTKit
//
//  Created by Nikolai Nobadi on 5/12/25.
//

/// A structure representing HTTP headers to be included in a request.
/// Supports standard headers like Accept, Content-Type, and Authorization,
/// as well as any number of custom headers.
public struct HTTPRequestHeaders {
    public var accept: MediaType?
    public var contentType: MediaType?
    public var authorization: String?
    public var custom: [String: String] = [:]
    
    /// Creates a new set of HTTP headers with optional standard fields and custom values.
    ///
    /// - Parameters:
    ///   - accept: Value for the "Accept" header, if any.
    ///   - contentType: Value for the "Content-Type" header, if any.
    ///   - authorization: Value for the "Authorization" header, if any.
    ///   - custom: Additional header fields to include.
    public init(accept: MediaType? = nil, contentType: MediaType? = nil, authorization: String? = nil, custom: [String : String] = [:]) {
        self.accept = accept
        self.contentType = contentType
        self.authorization = authorization
        self.custom = custom
    }
}


// MARK: - Dependencies
extension HTTPRequestHeaders {
    /// Represents a supported HTTP media type for headers like "Accept" and "Content-Type".
    public enum MediaType {
        /// JSON media type: `application/json`.
        case json

        /// Plain text media type: `text/plain`.
        case plainText

        /// A custom media type string (e.g., `image/png`).
        case custom(String)

        /// The string representation of the media type suitable for HTTP headers.
        var value: String {
            switch self {
            case .json:
                return "application/json"
            case .plainText:
                return "text/plain"
            case .custom(let type):
                return type
            }
        }
    }
}


// MARK: - Helpers Methods
extension HTTPRequestHeaders {
    /// Converts all non-nil header fields into a `[String: String]` dictionary.
    /// Includes standard headers and merges in custom values.
    func asDictionary() -> [String: String] {
        var dict: [String: String] = [:]

        if let accept {
            dict["Accept"] = accept.value
        }

        if let contentType {
            dict["Content-Type"] = contentType.value
        }

        if let authorization {
            dict["Authorization"] = authorization
        }

        for (key, value) in custom {
            dict[key] = value
        }

        return dict
    }
}
