//
//  StringFormattedDateTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 5/19/26.
//

import Testing
@testable import Movies

@Suite("🧪 String+FormattedDate")
struct StringFormattedDateTests {
    @Test
    func formattedDateValidDate() {
        let result = "2024-01-15".formattedDate
        #expect(result == "15 January, 2024")
    }
    
    @Test
    func formattedDateInvalidDate() {
        let result = "data-invalida".formattedDate
        #expect(result == "data-invalida")
    }
    
    @Test
    func formattedDateEmptyString() {
        let result = "".formattedDate
        #expect(result == "")
    }
}
