//
//  TMDBConfig.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/16/26.
//

import Foundation

enum TMDBConfig {
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    static func posterURL(_ path: String?) -> URL? {
        guard let path else { return nil }
        return URL(string: "\(imageBaseURL)\(path)")
    }
}
