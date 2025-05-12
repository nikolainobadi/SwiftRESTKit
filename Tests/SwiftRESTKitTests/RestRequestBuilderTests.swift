//
//  RestRequestBuilderTests.swift
//  SwiftRESTKit
//
//  Created by Nikolai Nobadi on 5/12/25.
//

import Testing
import Foundation
@testable import SwiftRESTKit

struct RestRequestBuilderTests {
    private let timeout: TimeInterval = 5
    private let baseURL = URL(string: "https://example.com")!
    private let cache: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData
}


// MARK: - Unit Tests
extension RestRequestBuilderTests {
    @Test("Builds GET request with query and headers")
    func buildsGETRequestWithQueryAndHeaders() throws {
        let query = ["q": "search"]
        let headers = makeHeaders(authorization: "Bearer token")
        let request = try RestRequestBuilder.buildGET(baseURL: baseURL, path: "endpoint", query: query, headers: headers, timeoutInterval: timeout, cachePolicy: cache)

        #expect(request.url?.absoluteString == "https://example.com/endpoint?q=search")
        #expect(request.httpMethod == "GET") // since GET is the default
        #expect(request.timeoutInterval == timeout)
        #expect(request.cachePolicy == cache)
        assertHeadersMatch(request, headers: headers)
    }

    @Test("Builds DELETE request with method and headers")
    func buildsDELETERequestWithMethodAndHeaders() {
        let headers = makeHeaders(authorization: "auth")
        let request = RestRequestBuilder.buildDELETE(baseURL: baseURL, path: "delete-path", headers: headers, timeoutInterval: timeout, cachePolicy: cache)

        #expect(request.url?.absoluteString == "https://example.com/delete-path")
        #expect(request.httpMethod == "DELETE")
        #expect(request.timeoutInterval == timeout)
        #expect(request.cachePolicy == cache)
        assertHeadersMatch(request, headers: headers)
    }

    @Test("Builds write request with method, body, and headers")
    func buildsWriteRequestWithMethodBodyAndHeaders() throws {
        let headers = makeHeaders(contentType: .json)
        let body = ["name": "Somebody"]
        let request = try RestRequestBuilder.buildWrite(baseURL: baseURL, path: "post-endpoint", method: .post, body: body, headers: headers, timeoutInterval: timeout, cachePolicy: cache)

        #expect(request.url?.absoluteString == "https://example.com/post-endpoint")
        #expect(request.httpMethod == HTTPWriteMethod.post.httpMethod)
        #expect(request.timeoutInterval == timeout)
        #expect(request.cachePolicy == cache)
        assertHeadersMatch(request, headers: headers)

        let bodyData = try #require(request.httpBody)
        let json = try #require(try JSONSerialization.jsonObject(with: bodyData) as? [String: String])
        
        #expect(json == body)
    }
}


// MARK: - Private Helpers
private extension RestRequestBuilderTests {
    func makeHeaders(
        accept: HTTPRequestHeaders.MediaType? = .json,
        contentType: HTTPRequestHeaders.MediaType? = nil,
        authorization: String? = nil,
        custom: [String: String] = [:]
    ) -> HTTPRequestHeaders {
        .init(accept: accept, contentType: contentType, authorization: authorization, custom: custom)
    }

    func assertHeadersMatch(_ request: URLRequest, headers: HTTPRequestHeaders) {
        let dict = headers.asDictionary()
        for (key, value) in dict {
            #expect(request.value(forHTTPHeaderField: key) == value)
        }
    }
}
