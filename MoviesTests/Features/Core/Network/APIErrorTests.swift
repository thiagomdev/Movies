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
}
