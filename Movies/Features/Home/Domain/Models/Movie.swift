//
//  Movie.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import Foundation

struct Movie: Codable, Equatable, Hashable {
    let page: Int
    let results: [MovieResult]
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
