//
//  MovieStoreTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 5/19/26.
//

import Testing
import Foundation
@testable import Movies

@MainActor
@Suite("🧪 Movie Store")
struct MovieStoreTests {
    @Test
    func sendShouldBeReturnedEmpty() async throws {
        let (sut, spy) = makeSut()
        
        sut.send(.fetchMovies)
        try await Task.sleep(for: .milliseconds(100))
        
        #expect(spy.executeCalled)
        #expect(spy.executeCount == 1)
        #expect(spy.shouldBeReturned.isEmpty)
    }
    
    @Test
    func sendShouldBeReturnedOneValue() async throws {
        let (sut, spy) = makeSut()
        spy.shouldBeReturned = [.fixture]
        
        sut.send(.fetchMovies)
        try await Task.sleep(for: .milliseconds(100))
        
        #expect(spy.executeCalled)
        #expect(spy.executeCount == 1)
        #expect(spy.shouldBeReturned.isEmpty == false)
    }
    
    @Test
    func sendShouldBeReturnedMoreThanOneValue() async throws {
        let (sut, spy) = makeSut()
        spy.shouldBeReturned = [.fixture, .fixture, .fixture, .fixture]
        
        sut.send(.fetchMovies)
        try await Task.sleep(for: .milliseconds(100))
        
        #expect(spy.executeCalled)
        #expect(spy.executeCount == 1)
        #expect(spy.shouldBeReturned.isEmpty == false)
    }
    
    @Test
    func sendShouldBeReturnedFailed() async throws {
        let (sut, spy) = makeSut()
        spy.shouldFail = NSError(domain: "error", code: 0)
        
        sut.send(.fetchMovies)
        try await Task.sleep(for: .milliseconds(100))
        
        #expect(spy.executeCalled)
        #expect(spy.executeCount == 1)
        #expect(sut.state == .failed("The operation couldn’t be completed. (error error 0.)"))
    }
}

extension MovieStoreTests {
    private func makeSut() -> (sut: MovieStore, spy: MovieStoreSpy) {
        let spy = MovieStoreSpy()
        let sut = MovieStore(useCase: spy)
        return (sut, spy)
    }
}

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
