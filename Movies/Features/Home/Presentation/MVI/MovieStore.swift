//
//  MovieStore.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/18/26.
//

import Combine
import Foundation

@MainActor
final class MovieStore: ObservableObject {
    @Published var state: MovieState = .loading
    
    private let useCase: MovieUseCaseProtocol
    
    init(useCase: MovieUseCaseProtocol) {
        self.useCase = useCase
    }
}

extension MovieStore {
    func send(_ intent: MovieIntent) {
        switch intent {
        case .fetchMovies:
            Task { try await fetchMovies() }
        }
    }
}

extension MovieStore {
    private func fetchMovies() async throws {
        state = .loading
        do {
            let movies = try await useCase.execute()
            state = .loaded(movies)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}
