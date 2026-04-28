//
//  Fixture.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/28/26.
//

@testable import Movies

extension Movie {
    static func fixture() -> Self {
        .init(page: 0, results: [.fixture], totalPages: nil, totalResults: nil)
    }
}

extension MovieResult {
    static var fixture: Self {
        .init(
            adult: false,
            backdropPath: nil,
            genreIDS: nil,
            id: 0,
            originalLanguage: nil,
            originalTitle: nil,
            overview: "",
            popularity: 0.0,
            posterPath: nil ,
            releaseDate: nil,
            title: nil,
            video: false,
            voteAverage: nil,
            voteCount: nil
        )
    }
}
