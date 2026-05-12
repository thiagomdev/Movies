//
//  MovieEndpoint.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/12/26.
//

import Foundation

enum MovieEndpoint: APIEndpoint {
    case endpoint
    
    var path: String {
        switch self {
        case .endpoint:
            return "/3/discover/movie"
        }
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var timeout: TimeInterval {
        return 10
    }
}
