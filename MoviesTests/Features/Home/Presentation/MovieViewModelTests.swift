//
//  MovieViewModelTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 4/28/26.
//

import Testing
import Foundation
@testable import Movies

@MainActor
struct MovieViewModelTests {
    @Test("fetchMovies - should populate movies when use case succeeds")
    func fetchMovies_withSuccess() async throws {
        let (sut, spy) = makeSut()
        spy.expected = [.fixture]
        
        try await sut.fetchMovies()
        
        #expect(spy.executeCalled)
        #expect(spy.executeCount == 1)
        #expect(spy.expected == [.fixture])
        #expect(spy.expected.count == 1)
    }
    
    @Test("fetchMovies - should set errorMessage when use case fails")
    func fetchMovies_withError() async throws {
        let (sut, spy) = makeSut()
        spy.errorToThrow = anyError
        
        try await sut.fetchMovies()
        
        #expect(spy.executeCalled)
        #expect(spy.executeCount == 1)
        #expect(sut.errorMessage == "Failed to fetch movies")
    }
}

extension MovieViewModelTests {
    private func makeSut() -> (sut: MovieViewModel, spy: MovieViewModelSpy) {
        let spy = MovieViewModelSpy()
        let sut = MovieViewModel(useCase: spy)
        return (sut, spy)
    }
}

extension MovieViewModelTests {
    private var anyError: Error {
        NSError(
            domain: "error",
            code: -999,
            userInfo: [NSLocalizedDescriptionKey: "Failed to fetch movies"]
        )
    }
}
