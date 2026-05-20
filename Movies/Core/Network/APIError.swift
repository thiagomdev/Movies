//
//  APIError.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/12/26.
//

import Foundation

// MARK: - API Error
enum APIError: LocalizedError, Equatable {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError(Error)
    case networkError(Error)
    case unauthorized
    case notFound
    case rateLimited
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The request URL is invalid."
        case .invalidResponse:
            return "Received an invalid response from the server."
        case .httpError(let code):
            return "Server returned error code \(code)."
        case .decodingError:
            return "Failed to process the server response."
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .unauthorized:
            return "Authentication failed. Check your API credentials."
        case .notFound:
            return "The requested resource was not found."
        case .rateLimited:
            return "Too many requests. Please try again later."
        }
    }

    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.invalidResponse, .invalidResponse),
             (.unauthorized, .unauthorized),
             (.notFound, .notFound),
             (.rateLimited, .rateLimited):
            return true
        case let (.httpError(a), .httpError(b)):
            return a == b
        case let (.decodingError(a), .decodingError(b)):
            let na = a as NSError
            let nb = b as NSError
            return na.domain == nb.domain && na.code == nb.code && na.localizedDescription == nb.localizedDescription
        case let (.networkError(a), .networkError(b)):
            let na = a as NSError
            let nb = b as NSError
            return na.domain == nb.domain && na.code == nb.code && na.localizedDescription == nb.localizedDescription
        default:
            return false
        }
    }
}
