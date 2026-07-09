//
//  ContentView.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import SwiftUI

struct MovieView: View {
    @State var store: MovieStore
    
    var body: some View {
        NavigationStack {
            VStack {
                switch store.state {
                case .loading:
                    ProgressView()
                        .accessibilityIdentifier("movieLoadingIndicator")
                case let .loaded(movies):
                    MovieList(movies: movies)
                        .listStyle(.inset)
                        .navigationDestination(for: MovieResult.self) { movie in
                            MovieDetailView(movie: movie)
                        }
                case let .failed(error):
                    Text(error.localizedDescription)
                        .accessibilityIdentifier("movieErrorMessage")
                }
            }
            .navigationTitle("Movies")
        }
        .task {
            await store.send(.fetchMovies)
        }
    }
}

#Preview {
    MovieFactory.make()
}
