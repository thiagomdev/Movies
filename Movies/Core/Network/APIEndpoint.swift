//
//  APIEndpoint.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/12/26.
//

import Foundation

// MARK: - APIClient Endpoint
public protocol APIClientEndpoint {
    var baseURL: String { get }
    var endpoint: String { get }
    var httpMethod: HTTPMethod { get }
    
    var parameters: [String: String]? { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var timeout: TimeInterval { get }
}
