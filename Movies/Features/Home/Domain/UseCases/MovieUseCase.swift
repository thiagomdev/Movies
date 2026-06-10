//
//  MovieUseCase.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import Foundation

enum MovieUSeCase {
    case movies
}

protocol MovieUseCaseProtocol {
    func execute(_ actions: MovieUSeCase) async throws -> [MovieResult]
}

final class MovieUseCase {
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
}

extension MovieUseCase: MovieUseCaseProtocol {
    func execute(_ actions: MovieUSeCase) async throws -> [MovieResult] {
        switch actions {
        case .movies:
            try await repository.fetchMovies()
        }
    }
}
