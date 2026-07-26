//
//  MovieAPIClientTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 5/19/26.
//

import Testing
import Foundation
import Movies

@Suite("🧪 Movie API Client", .serialized)
struct MovieAPIClientTests {
    
    init() {
        URLProtocolStub.requestHandler = nil
    }
    
    @Test(arguments: [200, 201, 226, 299])
    func request_success(code: Int) async throws {
        let expectedMovies: Movie = .fixture
        let data = try JSONEncoder().encode(expectedMovies)
        defer { URLProtocolStub.requestHandler = nil }

        URLProtocolStub.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: .anyURL,
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, data)
        }

        let sut = makeSut()

        let result: Movie = try await sut.request(MoviesEndpoint.movies)
        #expect(result.results == expectedMovies.results)
    }

    @Test(arguments: [199, 300, 400, 500])
    func request_httpError_forNon2xxCodes(code: Int) async throws {
        defer { URLProtocolStub.requestHandler = nil }
        URLProtocolStub.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: .anyURL,
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }

        let sut = makeSut()

        await #expect(throws: APIError.httpError(statusCode: code)) {
            let _: Movie = try await sut.request(MoviesEndpoint.movies)
        }
    }
    
    @Test(arguments: zip(
        [401, 404, 429, 500],
        [APIError.unauthorized, .notFound, .rateLimited, .httpError(statusCode: 500)]
    ))
    func request_throwsExpectedError(code: Int, expectedError: APIError) async throws {
        defer { URLProtocolStub.requestHandler = nil }
        URLProtocolStub.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: .anyURL,
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }

        let sut = makeSut()

        await #expect(throws: expectedError) {
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
