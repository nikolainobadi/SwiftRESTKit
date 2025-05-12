//
//  RestRequestBuilder.swift
//  SwiftRESTKit
//
//  Created by Nikolai Nobadi on 5/12/25.
//

import Foundation

enum RestRequestBuilder {
    static func buildGET(baseURL: URL, path: String, query: [String: String]? = nil, headers: HTTPRequestHeaders = .init(), timeoutInterval: TimeInterval? = nil, cachePolicy: URLRequest.CachePolicy? = nil) throws -> URLRequest {
        guard let url = buildURL(base: baseURL, path: path, query: query) else {
            throw RequestBuilderError.invalidURL
        }

        return makeRequest(url: url, headers: headers.asDictionary(), timeoutInterval: timeoutInterval, cachePolicy: cachePolicy)
    }

    static func buildDELETE(baseURL: URL, path: String, headers: HTTPRequestHeaders = .init(), timeoutInterval: TimeInterval? = nil, cachePolicy: URLRequest.CachePolicy? = nil) -> URLRequest {
        let url = baseURL.appendingPathComponent(path)

        return makeRequest(url: url, method: "DELETE", headers: headers.asDictionary(), timeoutInterval: timeoutInterval, cachePolicy: cachePolicy)
    }

    static func buildWrite(baseURL: URL, path: String, method: HTTPWriteMethod, body: [String: Any], headers: HTTPRequestHeaders = .init(), timeoutInterval: TimeInterval? = nil, cachePolicy: URLRequest.CachePolicy? = nil) throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        let bodyData = try JSONSerialization.data(withJSONObject: body)

        return makeRequest(url: url, method: method.httpMethod, headers: headers.asDictionary(), bodyData: bodyData, timeoutInterval: timeoutInterval, cachePolicy: cachePolicy)
    }
}


// MARK: - Private Methods
private extension RestRequestBuilder {
    static func makeRequest(url: URL, method: String? = nil, headers: [String: String], bodyData: Data? = nil, timeoutInterval: TimeInterval? = nil, cachePolicy: URLRequest.CachePolicy? = nil) -> URLRequest {
        var request = URLRequest(url: url)

        if let method {
            request.httpMethod = method
        }

        if let bodyData {
            request.httpBody = bodyData
        }

        if let timeoutInterval {
            request.timeoutInterval = timeoutInterval
        }

        if let cachePolicy {
            request.cachePolicy = cachePolicy
        }

        headers.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        return request
    }

    static func buildURL(base: URL, path: String, query: [String: String]?) -> URL? {
        let url = base.appendingPathComponent(path)

        guard let query, !query.isEmpty else {
            return url
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }

        return components?.url
    }
}
