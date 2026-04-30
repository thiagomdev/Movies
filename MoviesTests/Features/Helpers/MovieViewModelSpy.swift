//
//  MovieViewModelSpy.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/28/26.
//

@testable import Movies

final class MovieViewModelSpy: MovieUseCasing {
    var expected: [MovieResult] = []
    var errorToThrow: Error?
    
    private(set) var executeCalled: Bool = false
    private(set) var executeCount: Int = 0
    
    func execute() async throws -> [MovieResult] {
        executeCalled = true
        executeCount += 1
        
        if let error = errorToThrow {
            throw error
        }
        return expected
    }
}
