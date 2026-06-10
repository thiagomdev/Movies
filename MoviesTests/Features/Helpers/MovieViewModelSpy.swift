//
//  MovieViewModelSpy.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/28/26.
//

@testable import Movies

final class MovieViewModelSpy: MovieUseCaseProtocol {
    var expected: [MovieResult] = []
    var errorToThrow: Error?
    var expectedActions: MovieUSeCase?
    
    private(set) var executeCalled: Bool = false
    private(set) var executeCount: Int = 0
    
    func execute(_ actions: MovieUSeCase) async throws -> [MovieResult] {
        executeCalled = true
        executeCount += 1
        
        expectedActions = actions
      
        if let error = errorToThrow {
            throw error
        }
        return expected
    }
}
