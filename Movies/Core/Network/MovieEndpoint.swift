//
//  MovieEndpoint.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/12/26.
//

import Foundation

public enum MoviesEndpoint: APIClientEndpoint {
    case movies
    
    public var baseURL: String { "https://api.themoviedb.org" }
    
    public var endpoint: String { "/3/discover/movie" }
    
    public var httpMethod: HTTPMethod { .get }
    
    public var parameters: [String : String]? { nil }
    
    public var headers: [String : String]? { nil }
    
    public var body: Data? { nil }
    
    public var timeout: TimeInterval { return 3 }
}
