//
//  TMDBConfig.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/16/26.
//

import Foundation

public enum TMDBConfig {
    public static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    public static func posterURL(_ path: String?) -> URL? {
        guard let path else { return nil }
        return URL(string: "\(imageBaseURL)\(path)")
    }
}
