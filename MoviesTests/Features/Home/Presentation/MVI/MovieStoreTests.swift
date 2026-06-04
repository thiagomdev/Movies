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
@Suite("🧪 Movie Store", .serialized)
final class MovieStoreTests: LeakTrackerSuite {
    @Test
    func sendShouldBeReturnedEmpty() async {
        let (sut, spy) = makeSut()
        
        await sut.send(.fetchMovies)
        
        #expect(spy.executeCalled)
        #expect(spy.executeCount == 1)
        #expect(spy.shouldBeReturned.isEmpty)
    }
    
    @Test
    func sendShouldBeReturnedOneValue() async throws {
        let (sut, spy) = makeSut()
        spy.shouldBeReturned = [.fixture]
        
        await sut.send(.fetchMovies)
        
        #expect(spy.executeCalled)
        #expect(spy.executeCount == 1)
        #expect(spy.shouldBeReturned.isEmpty == false)
    }
    
    @Test
    func sendShouldBeReturnedMoreThanOneValue() async throws {
        let (sut, spy) = makeSut()
        spy.shouldBeReturned = [.fixture, .fixture, .fixture, .fixture]
        
        await sut.send(.fetchMovies)
        
        #expect(spy.executeCalled)
        #expect(spy.executeCount == 1)
        #expect(spy.shouldBeReturned.isEmpty == false)
    }
    
    @Test
    func sendShouldBeReturnedFailed() async throws {
        let (sut, spy) = makeSut()
        let anyError: NSError = .init(domain: "anyError", code: -999)
        spy.shouldFail = .networkError(anyError)

        await sut.send(.fetchMovies)

        #expect(spy.executeCalled)
        #expect(spy.executeCount == 1)
        #expect(sut.state == .failed(.networkError(anyError)))
    }

    @Test
    func sendShouldBeReturnedFailedWhenUnknownErrorIsThrown() async throws {
        let (sut, spy) = makeSut()
        let unknownError: NSError = .init(domain: "unknownError", code: -999)
        spy.shouldFailWithUnknownError = unknownError

        await sut.send(.fetchMovies)

        #expect(spy.executeCalled)
        #expect(spy.executeCount == 1)
        #expect(sut.state == .failed(.networkError(unknownError)))
    }
}

extension MovieStoreTests {
    private func makeSut(sourceLocation: SourceLocation = #_sourceLocation) -> (sut: MovieStore, spy: MovieStoreSpy) {
        let spy = MovieStoreSpy()
        let sut = MovieStore(useCase: spy)
        
        trackForMemoryLeak(sut, source: sourceLocation)
        trackForMemoryLeak(spy, source: sourceLocation)
        
        return (sut, spy)
    }
}
