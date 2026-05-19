//
//  MovieRepositoryMock.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/28/26.
//

import Foundation
@testable import Movies

final class MovieRepositoryMock: RemoteDataSourceProtocol {
    var expectedData: Movie = .fixture
    
    private(set) var requestCalled: Bool = false
    private(set) var requestCount: Int = 0
    
    func fetchMovies() async throws -> Movie {
        requestCalled = true
        requestCount += 1
        return expectedData
    }
}
