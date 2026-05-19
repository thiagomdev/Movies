//
//  MovieResult.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/12/26.
//

struct MovieResult: Codable, Equatable, Hashable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String
    let popularity: Double
    let posterPath: String?
    var releaseDate: String?
    let title: String?
    let video: Bool
    let voteAverage: Double?
    let voteCount: Int?
}
