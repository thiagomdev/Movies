//
//  MoviesEndpointTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 5/19/26.
//

import Testing
import Movies

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
        #expect(sut.headers == nil)
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
