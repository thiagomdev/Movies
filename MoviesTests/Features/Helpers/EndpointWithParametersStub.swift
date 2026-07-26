//
//  EndpointWithParametersStub.swift
//  Movies
//
//  Created by Thiago Monteiro on 7/26/26.
//

import Foundation
@testable import Movies

struct EndpointWithParametersStub: APIClientEndpoint {
    var baseURL: String { "https://api.themoviedb.org" }
    var endpoint: String { "/3/discover/movie" }
    var httpMethod: HTTPMethod { .get }
    var parameters: [String: String]? { ["page": "1"] }
    var headers: [String: String]? { nil }
    var body: Data? { nil }
    var timeout: TimeInterval { 3 }
}
