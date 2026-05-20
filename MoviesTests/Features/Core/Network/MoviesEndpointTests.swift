//
//  MoviesEndpointTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 5/19/26.
//

import Testing
@testable import Movies

@Suite("🧪 Movies Endpoint", .serialized)
struct MoviesEndpointTests {
    
    private let sut = MoviesEndpoint.movies
    
    @Test
    func baseURL() {
        #expect(sut.baseURL == "https://api.themoviedb.org")
    }
    
    @Test
    func endpoint() {
        #expect(sut.endpoint == "/3/discover/movie")
    }
    
    @Test
    func httpMethod() {
        #expect(sut.httpMethod == .get)
    }
    
    @Test
    func parameters() {
        #expect(sut.parameters == nil)
    }
    
    @Test
    func headers() {
        #expect(sut.headers == [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZjk0NDk4ZDA0ZGFjZDFjZjk2NjQ4YmIxN2NlYmM2NyIsIm5iZiI6MTY5MzQwMDczNS44NjA5OTk4LCJzdWIiOiI2NGVmM2U5Zjk3YTRlNjAwYzQ4NjJjZGIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.AAAJG3OLN5csc3p4V0MJyNwmMpGbPJcIIU-SwYWDrv8"
        ])
    }
    
    @Test
    func body() {
        #expect(sut.body == nil)
    }
    
    @Test
    func timeout() {
        #expect(sut.timeout == 3)
    }
}
