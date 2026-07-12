//
//  HTTPMethodTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 6/2/26.
//

import Testing
import Movies

@Suite("🧪 HTTP Method")
struct HTTPMethodTests {
    @Test
    func getRawValue() {
        #expect(HTTPMethod.get.rawValue == "GET")
    }

    @Test
    func postRawValue() {
        #expect(HTTPMethod.post.rawValue == "POST")
    }

    @Test
    func putRawValue() {
        #expect(HTTPMethod.put.rawValue == "PUT")
    }

    @Test
    func deleteRawValue() {
        #expect(HTTPMethod.delete.rawValue == "DELETE")
    }
}
