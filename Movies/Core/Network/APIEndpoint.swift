//
//  APIEndpoint.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/12/26.
//

import Foundation
// MARK: - API Endpoint
protocol APIEndpoint {
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var method: HTTPMethod { get }
    var timeout: TimeInterval { get }
}
