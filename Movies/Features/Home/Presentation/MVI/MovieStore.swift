//
//  MovieStore.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/18/26.
//

import Foundation

@MainActor
@Observable
public final class MovieStore {
    private let useCase: MovieUseCaseProtocol
    public var state: LoadState<[MovieResult]> = .loading
    
    public init(useCase: MovieUseCaseProtocol) {
        self.useCase = useCase
    }
}

extension MovieStore {
    public func send(_ intent: MovieIntent) async {
        switch intent {
        case .fetchMovies:
            await fetchMovies()
        }
    }
}

extension MovieStore {
    private func fetchMovies() async {
        state = .loading
        do {
            let movies = try await useCase.execute(.movies)
            state = .loaded(movies)
        } catch let error as APIError {
            state = .failed(error)
        } catch {
            state = .failed(.networkError(error))
        }
    }
}
