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
struct MovieStoreTests {
    @Test
    func sendShouldBeReturnedEmpty() async throws {
        let (sut, spy) = makeSut()
        
        sut.send(.fetchMovies)
        await waitForTaskCompletion()
        
        #expect(spy.executeCalled)
        #expect(spy.executeCount == 1)
        #expect(spy.shouldBeReturned.isEmpty)
    }
    
    @Test
    func sendShouldBeReturnedOneValue() async throws {
        let (sut, spy) = makeSut()
        spy.shouldBeReturned = [.fixture]
        
        sut.send(.fetchMovies)
        await waitForTaskCompletion()
        
        #expect(spy.executeCalled)
        #expect(spy.executeCount == 1)
        #expect(spy.shouldBeReturned.isEmpty == false)
    }
    
    @Test
    func sendShouldBeReturnedMoreThanOneValue() async throws {
        let (sut, spy) = makeSut()
        spy.shouldBeReturned = [.fixture, .fixture, .fixture, .fixture]
        
        sut.send(.fetchMovies)
        await waitForTaskCompletion()
        
        #expect(spy.executeCalled)
        #expect(spy.executeCount == 1)
        #expect(spy.shouldBeReturned.isEmpty == false)
    }
    
    @Test
    func sendShouldBeReturnedFailed() async throws {
        let (sut, spy) = makeSut()
        spy.shouldFail = NSError(domain: "error", code: 0)
        
        sut.send(.fetchMovies)
        await waitForTaskCompletion()
        
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

extension MovieStoreTests {
    private func waitForTaskCompletion() async {
        try? await Task.sleep(for: .milliseconds(100))
    }
}
