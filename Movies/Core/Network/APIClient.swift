//
//  MovieAPIClient.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/12/26.
//

import Foundation

protocol MoviAPIClientProtocol {
    func request<T: Decodable>(_ endpont: APIEndpoint) async throws -> T
}

final class MovieAPIClient {
    private let baseURL: String = "https://api.themoviedb.org"
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession) {
        self.session = session
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
}

extension MovieAPIClient: MoviAPIClientProtocol {
    func request<T>(_ endpont: APIEndpoint) async throws -> T where T : Decodable {
        guard var components = URLComponents(string: baseURL + endpont.path) else {
            throw APIError.invalidURL
        }
        components.queryItems = endpont.queryItems.isEmpty ? nil : endpont.queryItems
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = endpont.timeout
        urlRequest.httpMethod = endpont.method.rawValue
        urlRequest.allHTTPHeaderFields = [:]
        
        let (data, response) = try await performRequest(urlRequest)
        try validate(response: response)
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
}

extension MovieAPIClient {
    private func validate(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        switch httpResponse.statusCode {
        case 200...299:
            break
        case 401:
            throw APIError.unauthorized
        case 404:
            throw APIError.notFound
        case 429:
            throw APIError.rateLimited
        default:
            throw APIError.httpError(statusCode: httpResponse.statusCode)
        }
    }
}

extension MovieAPIClient {
    private func performRequest(_ urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        do {
            return try await session.data(for: urlRequest)
        } catch let error as APIError {
            throw error
        } catch let urlError as URLError where urlError.code == .cancelled {
            throw CancellationError()
        } catch {
            throw APIError.networkError(error)
        }
    }
}
