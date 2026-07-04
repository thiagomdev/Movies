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
        URLProtocolStub.requestHandler = nil
    }
    
    @Test
    func request_success() async throws {
        let expectedMovies: Movie = .fixture
        let data = try JSONEncoder().encode(expectedMovies)
        defer { URLProtocolStub.requestHandler = nil }
        URLProtocolStub.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: .anyURL,
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
        defer { URLProtocolStub.requestHandler = nil }
        URLProtocolStub.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: .anyURL,
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
        defer { URLProtocolStub.requestHandler = nil }
        URLProtocolStub.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: .anyURL,
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

    @Test
    func request_rateLimited() async throws {
        defer { URLProtocolStub.requestHandler = nil }
        URLProtocolStub.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: .anyURL,
                statusCode: 429,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }

        let sut = makeSut()

        await #expect(throws: APIError.rateLimited) {
            let _: Movie = try await sut.request(MoviesEndpoint.movies)
        }
    }

    @Test
    func request_httpError() async throws {
        defer { URLProtocolStub.requestHandler = nil }
        URLProtocolStub.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: .anyURL,
                statusCode: 500,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }

        let sut = makeSut()

        await #expect(throws: APIError.httpError(statusCode: 500)) {
            let _: Movie = try await sut.request(MoviesEndpoint.movies)
        }
    }

    @Test
    func request_decodingError() async throws {
        defer { URLProtocolStub.requestHandler = nil }
        URLProtocolStub.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: .anyURL,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data("not a valid json".utf8))
        }

        let sut = makeSut()

        await #expect(throws: APIError.self) {
            let _: Movie = try await sut.request(MoviesEndpoint.movies)
        }
    }

    @Test
    func request_networkError() async throws {
        defer { URLProtocolStub.requestHandler = nil }
        URLProtocolStub.requestHandler = { _ in
            throw URLError(.notConnectedToInternet)
        }

        let sut = makeSut()

        await #expect(throws: APIError.self) {
            let _: Movie = try await sut.request(MoviesEndpoint.movies)
        }
    }

    @Test
    func request_invalidURL() async throws {
        let sut = makeSut()

        await #expect(throws: APIError.invalidURL) {
            let _: Movie = try await sut.request(InvalidURLEndpointStub())
        }
    }

    @Test
    func request_cancellation() async throws {
        defer { URLProtocolStub.requestHandler = nil }
        URLProtocolStub.requestHandler = { _ in
            throw URLError(.cancelled)
        }

        let sut = makeSut()

        await #expect(throws: CancellationError.self) {
            let _: Movie = try await sut.request(MoviesEndpoint.movies)
        }
    }

    @Test
    func request_invalidResponse() async throws {
        defer { URLProtocolStub.requestHandler = nil }
        URLProtocolStub.requestHandler = { _ in
            let response = URLResponse(
                url: .anyURL,
                mimeType: nil,
                expectedContentLength: 0,
                textEncodingName: nil
            )
            return (response, Data())
        }

        let sut = makeSut()

        await #expect(throws: APIError.invalidResponse) {
            let _: Movie = try await sut.request(MoviesEndpoint.movies)
        }
    }
}
extension MovieAPIClientTests {
    private func makeSut() -> MovieAPIClient {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: config)
        return MovieAPIClient(session: session)
    }
}
