//
//  Movie.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import Foundation

public struct Movie: Codable, Equatable {
    let page: Int
    public let results: [MovieResult]
    let totalPages: Int?
    let totalResults: Int?

    public init(
        page: Int,
        results: [MovieResult],
        totalPages: Int?,
        totalResults: Int?) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
