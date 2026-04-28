//
//  MovieRepositoryMock.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/28/26.
//

import Foundation
@testable import Movies

final class MovieRepositoryMock: RemoteDataSourcing {
    var expectedData: Data?
    
    private(set) var requestCalled: Bool = false
    private(set) var requestCount: Int = 0
    
    func request() async throws -> Data {
        requestCalled = true
        requestCount += 1
        
        if let data = expectedData {
            return data
        }
        return Data()
    }
}
