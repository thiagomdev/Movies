//
//  ContentView.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import SwiftUI

struct MovieView: View {
    @StateObject var viewModel: MovieViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                MovieList(movies: $viewModel.movies)
                    .task {
                        Task {
                            try await viewModel.fetchMovies()
                        }
                    }
                    .listStyle(.inset)
                    .navigationDestination(for: MovieResult.self) { movie in
                        MovieDetailView(movie: movie)
                    }
            }
            .navigationTitle("Movies")
        }
    }
}

#Preview {
    MovieFactory.make()
}
