//
//  MovieRepositoryImplTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 4/22/26.
//

import Testing
import Foundation
@testable import Movies

@Suite("🧪 Movie Repository")
final class MovieRepositoryImplTests: LeakTrackerSuite {
    @Test
    func fetchMoviesDecodesArrayAndCallsDataSourceOnce() async throws {
        let (sut, mock) = makeSut()
        
        let result = try await sut.fetchMovies()
        
        #expect(mock.requestCalled)
        #expect(mock.requestCount == 1)
        #expect(mock.expectedData == .fixture)
        #expect(result.isEmpty == false)
    }
}

extension MovieRepositoryImplTests {
    private func makeSut(sourceLocation: SourceLocation = #_sourceLocation) -> (sut: MovieRepositoryImpl, mock: MovieRepositoryMock) {
        let mock = MovieRepositoryMock()
        let sut = MovieRepositoryImpl(dataSource: mock)
        
        trackForMemoryLeak(sut, source: sourceLocation)
        trackForMemoryLeak(mock, source: sourceLocation)
        
        return (sut, mock)
    }
}

extension MovieRepositoryImplTests {
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
