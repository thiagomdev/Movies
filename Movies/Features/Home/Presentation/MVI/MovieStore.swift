//
//  MovieStore.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/18/26.
//

import Foundation

@MainActor
@Observable
final class MovieStore {
    private(set) var state: LoadState<[MovieResult]> = .loading
    private var cancellationTask: Task<Void, Never>?
    
    private let useCase: MovieUseCaseProtocol
    
    init(useCase: MovieUseCaseProtocol) {
        self.useCase = useCase
    }
}

extension MovieStore {
    func send(_ intent: MovieIntent) async {
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
            let movies = try await useCase.execute()
            state = .loaded(movies)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}
