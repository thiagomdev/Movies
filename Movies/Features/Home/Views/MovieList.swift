//
//  MovieList.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/16/26.
//

import SwiftUI

struct MovieList: View {
    @Binding var movies: [MovieResult]
    
    var body: some View {
        List {
            ForEach(movies, id: \.id) { movie in
                NavigationLink(value: movie) {
                    HStack(alignment: .top, spacing: 12) {
                        AsyncImage(url: TMDBConfig.posterURL(movie.posterPath)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Rectangle()
                                .foregroundStyle(.secondary.opacity(0.3))
                        }
                        .frame(width: 90, height: 130)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(movie.title ?? "Unknown")
                                .font(.headline)
                                .fontDesign(.serif)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                            
                            Text(movie.overview)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .lineLimit(4)
                        }
                        .padding(.top, 4)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }
}
