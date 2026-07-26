//
//  UITestMovieRepositoryStub.swift
//  Movies
//
//  Created by Thiago Monteiro on 7/26/26.
//

#if DEBUG
struct UITestMovieRepositoryStub: MovieRepositoryProtocol {
    func fetchMovies() async throws -> [MovieResult] {
        [
            MovieResult(
                adult: false,
                backdropPath: nil,
                genreIDS: [28],
                id: 1,
                originalLanguage: "en",
                originalTitle: "UI Test Movie One",
                overview: "A movie used only for UI testing.",
                popularity: 10,
                posterPath: nil,
                releaseDate: "2026-01-01",
                title: "UI Test Movie One",
                video: false,
                voteAverage: 8.5,
                voteCount: 100
            ),
            MovieResult(
                adult: false,
                backdropPath: nil,
                genreIDS: [12],
                id: 2,
                originalLanguage: "en",
                originalTitle: "UI Test Movie Two",
                overview: "Another movie used only for UI testing.",
                popularity: 5,
                posterPath: nil,
                releaseDate: "2026-02-01",
                title: "UI Test Movie Two",
                video: false,
                voteAverage: 7.0,
                voteCount: 50
            )
        ]
    }
}
#endif
