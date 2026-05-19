//
//  MovieAPIClientTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 5/19/26.
//

import Testing
import Foundation
@testable import Movies

@MainActor
@Suite("🧪 Movie API Client", .serialized)
struct MovieAPIClientTests {
    @Test
    func request_unauthorized() async throws {
        URLProtocolMock.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: URL(string: "https://api.themoviedb.org/3/discover/movie")!,
                statusCode: 401,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }
        
        let sut = makeSut()
        
        await #expect(throws: Error.self) {
            let _: [MovieResult] = try await sut.request(MoviesEndpoint.movies)
        }
    }
    
    @Test
    func request_notFound() async throws {
        let sut = makeSut()
        
        URLProtocolMock.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: URL(string: "https://api.themoviedb.org/3/discover/movie")!,
                statusCode: 404,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }
        
        await #expect(throws: Error.self) {
            let _: [MovieResult] = try await sut.request(MoviesEndpoint.movies)
        }
    }
}

extension MovieAPIClientTests {
    private func makeSut() -> MovieAPIClient {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        return MovieAPIClient(session: session)
    }
}
