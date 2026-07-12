//
//  MovieAPIClient.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/12/26.
//

import Foundation

public protocol MoviAPIClientProtocol {
    func request<T: Decodable>(_ urlComponents: APIClientEndpoint) async throws -> T
}

public struct MovieAPIClient {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    public init(session: URLSession) {
        self.session = session
        self.decoder = JSONDecoder()
    }
}

extension MovieAPIClient: MoviAPIClientProtocol {
    public func request<T>(_ urlComponents: APIClientEndpoint) async throws -> T where T : Decodable {
        guard let url = URLComponents(string: urlComponents.baseURL + urlComponents.endpoint)?.url else {
            throw APIError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = urlComponents.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = urlComponents.headers
        
        let (data, response) = try await performRequest(urlRequest)
        try validate(response: response)
        Logger.log(request: urlRequest, response: response, data: data, error: nil)
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            Logger.log(request: nil, response: nil, data: nil, error: error)
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
        } catch let urlError as URLError where urlError.code == .cancelled {
            throw CancellationError()
        } catch {
            throw APIError.networkError(error)
        }
    }
}
