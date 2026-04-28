//
//  MovieUseCaseTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 4/27/26.
//

import Testing
@testable import Movies

@MainActor
struct MovieUseCaseTests {
    @Test
    func execute() async throws {
        let (sut, mock) = makeSut()
        mock.expected = [.fixture]
        
        let result = try await sut.execute()
        
        #expect(mock.fetchMoviesCalled)
        #expect(mock.fetchMoviesCount == 1)
        #expect(result == [.fixture])
        #expect(result.isEmpty == false)
    }
}

extension MovieUseCaseTests {
    private func makeSut() -> (sut: MovieUseCase, mock: MovieUseCaseMock) {
        let mock = MovieUseCaseMock()
        let sut = MovieUseCase(repository: mock)
        return (sut, mock)
    }
}
