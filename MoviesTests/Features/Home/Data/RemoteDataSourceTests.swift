//
//  RemoteDataSourceTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 4/17/26.
//

import Testing
import Foundation
@testable import Movies

struct RemoteDataSourceTests {
    @Test
    func request_success() async throws {
        let sut = makeSut()

        MockURLProtocol.requestHandlers[url] = { request in
            let response = HTTPURLResponse(
                url: url, statusCode: 200,
                httpVersion: "HTTP/1.1",
                headerFields: ["Content-Type": "application/json"]
            )!
            let data = #"{"id": 1, "name": "Alice"}"#.data(using: .utf8)!
            return (response, data)
        }

        let data = try await sut.request()

        #expect(data.isEmpty == false)
    }
}

extension RemoteDataSourceTests {
    private func makeSut() -> RemoteDataSource {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let sut = RemoteDataSource(session: session)
        return sut
    }
    
    private var url: URL {
        URL(string: "https://api.themoviedb.org/3/discover/movie")!
    }
}
