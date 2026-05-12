//
//  MovieUseCase.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import Foundation

protocol MovieUseCaseProtocol {
    func execute() async throws -> [MovieResult]
}

final class MovieUseCase {
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
}

extension MovieUseCase: MovieUseCaseProtocol {
    func execute() async throws -> [MovieResult] {
        let movies = try await repository.fetchMovies()
        return movies
    }
}
