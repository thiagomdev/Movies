//
//  ExtensionURLTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 6/2/26.
//

import Testing
import Foundation
@testable import Movies

@Suite("🧪 URL+anyURL")
struct ExtensionURLTests {
    @Test
    func anyURLAbsoluteString() {
        #expect(URL.anyURL.absoluteString == "https://mock.url")
    }
}
