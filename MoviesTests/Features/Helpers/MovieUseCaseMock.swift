//
//  MovieUseCaseMock.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/28/26.
//

@testable import Movies

final class MovieUseCaseMock: MovieRepositoring {
    var expected: [MovieResult] = []
    
    private(set) var fetchMoviesCalled: Bool = false
    private(set) var fetchMoviesCount: Int = 0
    
    func fetchMovies() async throws -> [MovieResult] {
        fetchMoviesCalled = true
        fetchMoviesCount += 1
        return expected
    }
}
