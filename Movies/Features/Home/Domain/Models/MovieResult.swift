//
//  MovieResult.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/12/26.
//

public struct MovieResult: Codable, Equatable, Hashable {
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
    
    public init(adult: Bool,
        backdropPath: String?,
        genreIDS: [Int]?,
        id: Int,
        originalLanguage: String?,
        originalTitle: String?,
        overview: String,
        popularity: Double,
        posterPath: String?,
        releaseDate: String? = nil,
        title: String?,
        video: Bool,
        voteAverage: Double?,
        voteCount: Int?) {
        
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
    
    enum CodingKeys: String, CodingKey {
        case adult, id, overview, popularity, title, video
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
