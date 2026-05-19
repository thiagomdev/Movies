//
//  RemoteDataSourceTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 4/17/26.
//

import Testing
import Foundation
@testable import Movies

@Suite("🧪 Remote DataSource")
struct RemoteDataSourceTests {
    @Test
    @MainActor
    func requestSuccess() async throws {
        let sut = makeSut()

        MockURLProtocol.requestHandlers[url] = { request in
            let response = HTTPURLResponse(
                url: url, statusCode: 200,
                httpVersion: "HTTP/1.1",
                headerFields: ["Content-Type": "application/json"]
            )!
            let data: Data = Data(json.utf8)
            return (response, data)
        }

        
        let data = try await sut.fetchMovies()

        #expect(data.results.isEmpty == false)
    }
}

extension RemoteDataSourceTests {
    private func makeSut() -> MovieRemoteDataSource {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let client = MovieAPIClient(session: session)
        let sut = MovieRemoteDataSource(apiClient: client)
        return sut
    }
}

extension RemoteDataSourceTests {
    private var url: URL {
        URL(string: "https://api.themoviedb.org/3/discover/movie")!
    }
    
    private var json: String {
        let json = """
        {
          "page": 1,
          "results": [
            {
              "adult": false,
              "backdrop_path": "/test_backdrop.jpg",
              "genre_ids": [28, 12],
              "id": 1,
              "original_language": "en",
              "original_title": "Test Movie",
              "overview": "A test movie overview.",
              "popularity": 100.0,
              "poster_path": "/test_poster.jpg",
              "release_date": "2024-01-01",
              "title": "Test Movie",
              "video": false,
              "vote_average": 7.5,
              "vote_count": 100
            }
          ],
          "total_pages": 1,
          "total_results": 1
        }
        """
        
        return json
    }
}
