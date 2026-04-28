//
//  MovieViewModelTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 4/28/26.
//

import Testing
@testable import Movies

@MainActor
struct MovieViewModelTests {
    @Test
    func fetchMovies() async throws {
        let (sut, spy) = makeSut()
        
        do {
            spy.expected = [.fixture]
            
            try await sut.fetchMovies()
            
            #expect(spy.executeCalled)
            #expect(spy.executeCount == 1)
            #expect(spy.expected == [.fixture])
        } catch {
            Issue.record("\(error)")
        }
    }
}

extension MovieViewModelTests {
    private func makeSut() -> (sut: MovieViewModel, spy: MovieViewModelSpy) {
        let spy = MovieViewModelSpy()
        let sut = MovieViewModel(useCase: spy)
        return (sut, spy)
    }
}
