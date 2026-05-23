//
//  Fixture.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/28/26.
//

@testable import Movies

extension Movie {
    static var fixture: Self {
        .init(page: 0, results: [.fixture], totalPages: 1, totalResults: 1)
    }
}

extension MovieResult {
    static var fixture: Self {
        .init(
            adult: false,
            backdropPath: "/test_backdrop.jpg",
            genreIDS: [28, 12],
            id: 1,
            originalLanguage: "en",
            originalTitle: "Test Movie",
            overview: "A test movie overview.",
            popularity: 100.0,
            posterPath: "/test_poster.jpg",
            releaseDate: "2024-01-01",
            title: "Test Movie",
            video: false,
            voteAverage: 7.5,
            voteCount: 100
        )
    }
}
