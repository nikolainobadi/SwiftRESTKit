//
//  HTTPRequestHeadersTests.swift
//  SwiftRESTKit
//
//  Created by Nikolai Nobadi on 5/12/25.
//

import Testing
@testable import SwiftRESTKit

struct HTTPRequestHeadersTests {
    private let json = "application/json"
    private let plainText = "text/plain"
}


// MARK: - Unit Tests
extension HTTPRequestHeadersTests {
    @Test("Includes only non-nil headers in the dictionary")
    func includesOnlyNonNilHeaders() {
        let auth = "Bearer token"
        let custom = ["X-Custom-Header": "value"]
        let headers = makeHeaders(authorization: auth, custom: custom)
        let result = headers.asDictionary()

        assertHeadersMatch(result, accept: json, authorization: auth, custom: custom)
    }

    @Test("Encodes all standard headers when provided")
    func encodesAllStandardHeaders() {
        let authToken = "Token abc123"
        let headers = makeHeaders(accept: .plainText, contentType: .json, authorization: authToken)
        let result = headers.asDictionary()

        assertHeadersMatch(result, accept: plainText, contentType: json, authorization: authToken)
    }

    @Test("Merges custom headers with standard ones")
    func mergesCustomHeadersWithStandardOnes() {
        let custom = ["X-Request-ID": "123", "X-Feature-Flag": "beta"]
        let headers = makeHeaders(contentType: .json, custom: custom)
        let result = headers.asDictionary()

        assertHeadersMatch(result, accept: json, contentType: json, custom: custom)
    }

    @Test("Returns an empty dictionary when no headers are set")
    func returnsEmptyDictionaryWhenNoHeadersAreSet() {
        let headers = makeHeaders(accept: nil)
        let result = headers.asDictionary()

        assertHeadersMatch(result)
    }

    @Test("Returns the correct string for each media type")
    func returnsCorrectStringForEachMediaType() {
        let png = "image/png"

        #expect(HTTPRequestHeaders.MediaType.json.value == json)
        #expect(HTTPRequestHeaders.MediaType.plainText.value == plainText)
        #expect(HTTPRequestHeaders.MediaType.custom(png).value == png)
    }
}


// MARK: - Private Helpers
private extension HTTPRequestHeadersTests {
    func makeHeaders(
        accept: HTTPRequestHeaders.MediaType? = .json,
        contentType: HTTPRequestHeaders.MediaType? = nil,
        authorization: String? = nil,
        custom: [String: String] = [:]
    ) -> HTTPRequestHeaders {
        .init(accept: accept, contentType: contentType, authorization: authorization, custom: custom)
    }

    func assertHeadersMatch(
        _ result: [String: String],
        accept: String? = nil,
        contentType: String? = nil,
        authorization: String? = nil,
        custom: [String: String] = [:]
    ) {
        if let accept {
            #expect(result["Accept"] == accept)
        } else {
            #expect(result["Accept"] == nil)
        }

        if let contentType {
            #expect(result["Content-Type"] == contentType)
        } else {
            #expect(result["Content-Type"] == nil)
        }

        if let authorization {
            #expect(result["Authorization"] == authorization)
        } else {
            #expect(result["Authorization"] == nil)
        }

        for (key, expectedValue) in custom {
            #expect(result[key] == expectedValue)
        }
    }
}
