//
//  MovieStoreSpy.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/19/26.
//

@testable import Movies
final class MovieStoreSpy: MovieUseCaseProtocol {
    var shouldBeReturned: [MovieResult] = []
    var shouldFail: Error? = nil
    
    private(set) var executeCalled: Bool = false
    private(set) var executeCount: Int = 0
    
    func execute() async throws -> [MovieResult] {
        executeCalled = true
        executeCount += 1
        
        if let error = shouldFail {
            throw error
        }
        return shouldBeReturned
    }
}
