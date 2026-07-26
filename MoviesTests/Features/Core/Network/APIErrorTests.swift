//
//  APIErrorTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 5/19/26.
//

import Testing
import Foundation
import Movies

@Suite("🧪 API Error")
struct APIErrorTests {
    
    @Test
    func invalidURL() {
        #expect(APIError.invalidURL.errorDescription == "The request URL is invalid.")
    }
    
    @Test
    func invalidResponse() {
        #expect(APIError.invalidResponse.errorDescription == "Received an invalid response from the server.")
    }
    
    @Test
    func httpError() {
        #expect(APIError.httpError(statusCode: 404).errorDescription == "Server returned error code 404.")
    }
    
    @Test
    func decodingError() {
        let error = NSError(domain: "test", code: 0)
        #expect(APIError.decodingError(error).errorDescription == "Failed to process the server response.")
    }
    
    @Test
    func networkError() {
        let error = NSError(domain: "test", code: 0, userInfo: [NSLocalizedDescriptionKey: "offline"])
        #expect(APIError.networkError(error).errorDescription == "Network error: offline")
    }
    
    @Test
    func unauthorized() {
        #expect(APIError.unauthorized.errorDescription == "Authentication failed. Check your API credentials.")
    }
    
    @Test
    func notFound() {
        #expect(APIError.notFound.errorDescription == "The requested resource was not found.")
    }
    
    @Test
    func rateLimited() {
        #expect(APIError.rateLimited.errorDescription == "Too many requests. Please try again later.")
    }

    @Test
    func cancelled() {
        #expect(APIError.cancelled.errorDescription == "The request was cancelled.")
    }
}

extension APIErrorTests {
    @Test(arguments: [
        APIError.invalidURL,
        .invalidResponse,
        .unauthorized,
        .notFound,
        .rateLimited,
        .cancelled
    ])
    func trivialCasesAreEqualToThemselves(error: APIError) {
        #expect(error == error)
    }

    @Test
    func httpErrorIsEqualWhenStatusCodeMatches() {
        #expect(APIError.httpError(statusCode: 500) == .httpError(statusCode: 500))
    }

    @Test
    func httpErrorIsNotEqualWhenStatusCodeDiffers() {
        #expect(APIError.httpError(statusCode: 500) != .httpError(statusCode: 404))
    }

    @Test
    func decodingErrorIsEqualWhenUnderlyingNSErrorMatches() {
        let lhs = NSError(domain: "test", code: 1, userInfo: [NSLocalizedDescriptionKey: "bad json"])
        let rhs = NSError(domain: "test", code: 1, userInfo: [NSLocalizedDescriptionKey: "bad json"])
        #expect(APIError.decodingError(lhs) == .decodingError(rhs))
    }

    @Test
    func decodingErrorIsNotEqualWhenUnderlyingNSErrorDiffers() {
        let lhs = NSError(domain: "test", code: 1)
        let rhs = NSError(domain: "test", code: 2)
        #expect(APIError.decodingError(lhs) != .decodingError(rhs))
    }

    @Test
    func networkErrorIsEqualWhenUnderlyingNSErrorMatches() {
        let lhs = NSError(domain: "test", code: 1, userInfo: [NSLocalizedDescriptionKey: "offline"])
        let rhs = NSError(domain: "test", code: 1, userInfo: [NSLocalizedDescriptionKey: "offline"])
        #expect(APIError.networkError(lhs) == .networkError(rhs))
    }

    @Test
    func networkErrorIsNotEqualWhenUnderlyingNSErrorDiffers() {
        let lhs = NSError(domain: "test", code: 1)
        let rhs = NSError(domain: "other", code: 1)
        #expect(APIError.networkError(lhs) != .networkError(rhs))
    }

    @Test
    func differentCasesAreNeverEqual() {
        #expect(APIError.invalidURL != .notFound)
        #expect(APIError.httpError(statusCode: 500) != .rateLimited)
        #expect(APIError.cancelled != .invalidResponse)
    }
}
