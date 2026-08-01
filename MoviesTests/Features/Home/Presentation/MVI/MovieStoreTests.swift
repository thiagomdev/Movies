//
//  MovieStoreTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 5/19/26.
//

import Testing
import Foundation
import Movies

@MainActor
@Suite("🧪 Movie Store", .serialized)
final class MovieStoreTests: LeakTrackerSuite {
    @Test
    func sendShouldBeReturnedEmpty() async throws{
        let (sut, spy) = makeSut()
        
        try await expect(sut, spy: spy, when: .fetchMovies, then: {
            #expect(spy.shouldBeReturned.isEmpty)
            #expect(spy.shouldBeReturned.count == .zero)
        })
    }
    
    @Test
    func sendShouldBeReturnedOneValue() async throws {
        let (sut, spy) = makeSut()
        spy.shouldBeReturned = [.fixture]
        
        try await expect(sut, spy: spy, when: .fetchMovies, then: {
            #expect(spy.shouldBeReturned.isEmpty == false)
            #expect(spy.shouldBeReturned.count == 1)
        })
    }
    
    @Test
    func sendShouldBeReturnedMoreThanOneValue() async throws {
        let (sut, spy) = makeSut()
        spy.shouldBeReturned = [.fixture, .fixture, .fixture, .fixture]
        
        try await expect(sut, spy: spy, when: .fetchMovies, then: {
            #expect(spy.shouldBeReturned.isEmpty == false)
            #expect(spy.shouldBeReturned.count == 4)
        })
    }
    
    @Test
    func sendShouldBeReturnedFailed() async throws {
        let (sut, spy) = makeSut()
        let anyError: NSError = .init(domain: "anyError", code: -999)
        spy.shouldFail = .networkError(anyError)

        try await expect(sut, spy: spy, when: .fetchMovies, then: {
            #expect(sut.state == .failed(.networkError(anyError)))
        })
    }

    @Test
    func sendShouldBeReturnedFailedWhenUnknownErrorIsThrown() async throws {
        let (sut, spy) = makeSut()
        let unknownError: NSError = .init(domain: "unknownError", code: -999)
        spy.shouldFailWithUnknownError = unknownError

        try await expect(sut, spy: spy, when: .fetchMovies, then: {
            #expect(sut.state == .failed(.networkError(unknownError)))
        })
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

extension MovieStoreTests {
    private func expect(
        _ sut: MovieStore, spy: MovieStoreSpy,
        when expectedResult: MovieIntent,
        then execute: () -> Void,
        file: StaticString = #filePath,
        line: UInt = #line)  async throws {
        
        await sut.send(expectedResult)
            
        execute()
            
        #expect(spy.executeCalled)
        #expect(spy.executeCount == 1)
        #expect(expectedResult == .fetchMovies)
    }
}

