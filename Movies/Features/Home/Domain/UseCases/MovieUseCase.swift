//
//  MovieUseCase.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import Foundation

public enum MovieUSeCase {
    case movies
}

public protocol MovieUseCaseProtocol {
    func execute(_ actions: MovieUSeCase) async throws -> [MovieResult]
}

public final class MovieUseCase {
    private let repository: MovieRepositoryProtocol
    
    public init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
}

extension MovieUseCase: MovieUseCaseProtocol {
    public func execute(_ actions: MovieUSeCase) async throws -> [MovieResult] {
        switch actions {
        case .movies:
            try await repository.fetchMovies()
        }
    }
}
