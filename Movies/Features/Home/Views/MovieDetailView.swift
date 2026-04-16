//
//  MovieDetailView.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/16/26.
//

import SwiftUI
import Foundation

struct MovieDetailView: View {
    let movie: MovieResult

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: TMDBConfig.posterURL(movie.posterPath)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Rectangle()
                        .foregroundStyle(.secondary.opacity(0.3))
                }
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title ?? "Unknown")
                        .font(.title)
                        .bold()

                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text(String(format: "%.1f", movie.voteAverage ?? 0.0))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Spacer()

                        Text(movie.releaseDate?.formattedDate ?? "")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Divider()

                    Text("Overview")
                        .font(.headline)

                    Text(movie.overview)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(movie.title ?? "Movie")
        .navigationBarTitleDisplayMode(.inline)
    }
}
