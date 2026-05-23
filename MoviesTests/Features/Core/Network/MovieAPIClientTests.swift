//
//  MovieAPIClientTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 5/19/26.
//

import Testing
import Foundation
@testable import Movies

@Suite("🧪 Movie API Client", .serialized)
struct MovieAPIClientTests {
    
    init() {
        URLProtocolMock.requestHandler = nil
    }
    
    @Test
    func request_success() async throws {
        let expectedMovies: Movie = .fixture
        let data = try JSONEncoder().encode(expectedMovies)
        
        URLProtocolMock.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: anyURL,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, data)
        }
        
        let sut = makeSut()
        
        let result: Movie = try await sut.request(MoviesEndpoint.movies)
        #expect(result.results == expectedMovies.results)
    }
    
    @Test
    func request_unauthorized() async throws {
        URLProtocolMock.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: anyURL,
                statusCode: 401,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }
        
        let sut = makeSut()
        
        await #expect(throws: APIError.unauthorized) {
            let _: [Movie] = try await sut.request(MoviesEndpoint.movies)
        }
    }
    
    @Test
    func request_notFound() async throws {
        let sut = makeSut()
        
        URLProtocolMock.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: anyURL,
                statusCode: 404,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }
        
        await #expect(throws: APIError.notFound) {
            let _: [Movie] = try await sut.request(MoviesEndpoint.movies)
        }
    }
}

extension MovieAPIClientTests {
    private func makeSut() -> MovieAPIClient {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        return MovieAPIClient(session: session)
    }
}

extension MovieAPIClientTests {
    private var anyURL: URL {
        URL(string: "https://mock.url")!
    }
}
