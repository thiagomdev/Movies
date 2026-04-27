//
//  MovieRepositoryTest.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 4/22/26.
//

import Testing
import Foundation
@testable import Movies

@MainActor
struct MovieRepositoryTest {
    @Test
    func test_fetchMovies_decodesArrayAndCallsDataSourceOnce() async throws {
        let (sut, mock) = makeSut()
        
        do {
            mock.expectedData = Data(json.utf8)
            
            let result = try await sut.fetchMovies()
            
            #expect(mock.requestCalled)
            #expect(mock.requestCount == 1)
            #expect(!result.isEmpty)
        } catch {
            Issue.record("\(error)")
        }
    }
}

final class MovieRepositoryMock: RemoteDataSourcing {
    var expectedData: Data?
    
    private(set) var requestCalled: Bool = false
    private(set) var requestCount: Int = 0
    
    func request() async throws -> Data {
        requestCalled = true
        requestCount += 1
        
        if let data = expectedData {
            return data
        }
        return Data()
    }
}
extension MovieRepositoryTest {
    private func makeSut() -> (sut: MovieRepository, mock: MovieRepositoryMock) {
        let mock = MovieRepositoryMock()
        let sut = MovieRepository(dataSource: mock)
        return (sut, mock)
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

extension Movie {
    static func fixture() -> Self {
        .init(page: 0, results: [.fixture()], totalPages: nil, totalResults: nil)
    }
}

extension MovieResult {
    static func fixture() -> Self {
        .init(
            adult: false,
            backdropPath: nil,
            genreIDS: nil,
            id: 0,
            originalLanguage: nil,
            originalTitle: nil,
            overview: "",
            popularity: 0.0,
            posterPath: nil ,
            releaseDate: nil,
            title: nil,
            video: false,
            voteAverage: nil,
            voteCount: nil
        )
    }
}

