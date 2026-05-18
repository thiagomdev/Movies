//
//  ContentView.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import SwiftUI

struct MovieView: View {
    @StateObject var store: MovieStore
    
    var body: some View {
        NavigationStack {
            VStack {
                switch store.state {
                case .loading:
                    ProgressView()
                case let .loaded(movies):
                    MovieList(movies: movies)
                        .listStyle(.inset)
                        .navigationDestination(for: MovieResult.self) { movie in
                            MovieDetailView(movie: movie)
                        }
                case let .failed(error):
                    Text(error)
                }
            }
            .navigationTitle("Movies")
        }
        .onAppear {
            store.send(.fetchMovies)
        }
    }
}

#Preview {
    MovieFactory.make()
}
