//
//  MovieStoreSpy.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/19/26.
//

@testable import Movies
final class MovieStoreSpy: MovieUseCaseProtocol {
    var shouldBeReturned: [MovieResult] = []
    var shouldFail: APIError? = nil
    var shouldFailWithUnknownError: Error? = nil
    var expectedActions: MovieUSeCase?
    
    private(set) var executeCalled: Bool = false
    private(set) var executeCount: Int = 0
    
    func execute(_ actions: MovieUSeCase) async throws -> [MovieResult] {
        executeCalled = true
        executeCount += 1
        expectedActions = actions
        if let error = shouldFailWithUnknownError {
            throw error
        }
        if let error = shouldFail {
            throw error
        }
        return shouldBeReturned
    }
}
