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
    var expectedActions: RemoteDataSource?
    
    private(set) var requestCalled: Bool = false
    private(set) var requestCount: Int = 0
    
    func fetch(movie: RemoteDataSource) async throws -> Movie {
        requestCalled = true
        requestCount += 1
        expectedActions = movie
        return expectedData
    }
}
