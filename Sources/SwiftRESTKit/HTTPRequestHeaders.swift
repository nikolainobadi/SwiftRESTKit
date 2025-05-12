//
//  HTTPRequestHeaders.swift
//  SwiftRESTKit
//
//  Created by Nikolai Nobadi on 5/12/25.
//

struct HTTPRequestHeaders {
    var accept: MediaType?
    var contentType: MediaType?
    var authorization: String?
    var custom: [String: String] = [:]
}


// MARK: - Dependencies
extension HTTPRequestHeaders {
    enum MediaType {
        case json
        case plainText
        case custom(String)
        
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
    func asDictionary() -> [String: String] {
        var dict: [String: String] = [:]

        if let accept { dict["Accept"] = accept.value }
        if let contentType { dict["Content-Type"] = contentType.value }
        if let authorization { dict["Authorization"] = authorization }

        for (key, value) in custom {
            dict[key] = value
        }

        return dict
    }
}

