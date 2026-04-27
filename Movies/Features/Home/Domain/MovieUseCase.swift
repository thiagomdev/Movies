//
//  MovieUseCase.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import Foundation

protocol MovieUseCasing {
    func execute() async throws -> [MovieResult]
}

final class MovieUseCase {
    private let repository: MovieRepositoring
    
    init(repository: MovieRepositoring) {
        self.repository = repository
    }
}

extension MovieUseCase: MovieUseCasing {
    func execute() async throws -> [MovieResult] {
        let movies = try await repository.fetchMovies()
        return movies
            .filter { !$0.adult }
            .sorted { $0.popularity > $1.popularity }
    }
}
