//
//  MovieViewModel.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import SwiftUI
import Combine
import Foundation

@MainActor
final class MovieViewModel: ObservableObject {
    private let useCase: MovieUseCasing
    
    @Published var movies: [MovieResult] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(useCase: MovieUseCasing) {
        self.useCase = useCase
    }
}

extension MovieViewModel {
    func fetchMovies() async {
        isLoading = true
        defer { isLoading = false }
        do {
            movies = try await useCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
