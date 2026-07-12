//
//  TMDBConfigTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 6/2/26.
//

import Testing
import Foundation
import Movies

@Suite("🧪 TMDB Config")
struct TMDBConfigTests {
    @Test
    func imageBaseURLValue() {
        #expect(TMDBConfig.imageBaseURL == "https://image.tmdb.org/t/p/w500")
    }

    @Test
    func posterURLWithValidPath() {
        let url = TMDBConfig.posterURL("/poster.jpg")

        #expect(url?.absoluteString == "https://image.tmdb.org/t/p/w500/poster.jpg")
    }

    @Test
    func posterURLWithNilPath() {
        let url = TMDBConfig.posterURL(nil)

        #expect(url == nil)
    }
}
