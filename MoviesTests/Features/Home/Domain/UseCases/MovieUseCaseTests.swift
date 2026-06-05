//
//  MovieUseCaseTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 4/27/26.
//

import Testing
@testable import Movies

@Suite("🧪 Movie UseCase")
final class MovieUseCaseTests: LeakTrackerSuite {
    @Test
    func executeShouldReturnResultMovie() async throws {
        let (sut, mock) = makeSut()
        mock.expected = [.fixture]
        
        let result = try await sut.execute(.movies)
        
        #expect(mock.fetchMoviesCalled)
        #expect(mock.fetchMoviesCount == 1)
        #expect(result == [.fixture])
        #expect(result.isEmpty == false)
    }
}

extension MovieUseCaseTests {
    private func makeSut(sourceLocation: SourceLocation = #_sourceLocation) -> (sut: MovieUseCase, mock: MovieUseCaseMock) {
        let mock = MovieUseCaseMock()
        let sut = MovieUseCase(repository: mock)
        
        trackForMemoryLeak(sut, source: sourceLocation)
        trackForMemoryLeak(mock, source: sourceLocation)
        
        return (sut, mock)
    }
}
