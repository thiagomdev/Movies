//
//  InvalidURLEndpointStub.swift
//  Movies
//
//  Created by Thiago Monteiro on 7/4/26.
//

import Foundation
@testable import Movies

struct InvalidURLEndpointStub: APIClientEndpoint {
    var baseURL: String { "http://[bad" }
    var endpoint: String { "" }
    var httpMethod: HTTPMethod { .get }
    var parameters: [String: String]? { nil }
    var headers: [String: String]? { nil }
    var body: Data? { nil }
    var timeout: TimeInterval { 3 }
}
