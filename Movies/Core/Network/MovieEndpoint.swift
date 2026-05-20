//
//  MovieEndpoint.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/12/26.
//

import Foundation

enum MoviesEndpoint: APIClientEndpoint {
    case movies
    
    var baseURL: String { "https://api.themoviedb.org" }
    
    var endpoint: String { "/3/discover/movie" }
    
    var httpMethod: HTTPMethod { .get }
    
    var parameters: [String : String]? { nil }
    
    var headers: [String : String]? { nil }
    
    var body: Data? { nil }
    
    var timeout: TimeInterval { return 3 }
}
