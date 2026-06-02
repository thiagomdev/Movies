//
//  MovieFactoryTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 6/2/26.
//

import Testing
import SwiftUI
@testable import Movies

@MainActor
@Suite("🧪 Movie Factory")
struct MovieFactoryTests {
    @Test
    func makeBuildsViewWithoutCrashing() {
        _ = MovieFactory.make()
    }
}
