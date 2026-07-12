//
//  LoggerTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 6/2/26.
//

import Testing
import Foundation
import Movies

@Suite("🧪 Logger")
struct LoggerTests {
    @Test
    func logWithFullRequestAndJSONResponse() {
        var request = URLRequest(url: .anyURL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        request.httpBody = Data("{\"key\":\"value\"}".utf8)
        let response = HTTPURLResponse(
            url: .anyURL,
            statusCode: 200,
            httpVersion: "HTTP/1.1",
            headerFields: ["X-Test": "true"]
        )
        let data = Data("{\"ok\":true}".utf8)

        Logger.log(request: request, response: response, data: data, error: nil)
    }

    @Test
    func logWithNon2xxStatusCode() {
        let response = HTTPURLResponse(url: .anyURL, statusCode: 500, httpVersion: nil, headerFields: nil)

        Logger.log(request: nil, response: response, data: nil, error: nil)
    }

    @Test
    func logWithNonHTTPResponseAndError() {
        let response = URLResponse(url: .anyURL, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let error = NSError(domain: "test", code: 1)

        Logger.log(request: nil, response: response, data: nil, error: error)
    }

    @Test
    func logWithoutResponseOrError() {
        Logger.log(request: nil, response: nil, data: nil, error: nil)
    }

    @Test
    func logWithInvalidJSONData() {
        let data = Data("not a json".utf8)

        Logger.log(request: nil, response: nil, data: data, error: nil)
    }

    @Test
    func logVerboseFalseSkipsHeadersAndBody() {
        var request = URLRequest(url: .anyURL)
        request.allHTTPHeaderFields = ["A": "B"]
        request.httpBody = Data("body".utf8)

        Logger.log(request: request, response: nil, data: nil, error: nil, verbose: false)
    }

    @Test
    func logError() {
        Logger.logError(error: NSError(domain: "x", code: 0), url: .anyURL)
    }

    @Test
    func logErrorWithNilURL() {
        Logger.logError(error: NSError(domain: "x", code: 0), url: nil)
    }
}
