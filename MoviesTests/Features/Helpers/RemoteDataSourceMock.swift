//
//  RemoteDataSourceMock.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/17/26.
//

import Foundation

final class MockURLProtocol: URLProtocol {
    static var requestHandlers = [URL: (URLRequest) throws -> (HTTPURLResponse, Data)]()

    override class func canInit(with request: URLRequest) -> Bool {
        return request.url.flatMap { MockURLProtocol.requestHandlers[$0] } != nil
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard
            let url = request.url,
            let handler = MockURLProtocol.requestHandlers[url]
        else {
            client?.urlProtocol(self, didFailWithError: URLError(.badURL))
            return
        }

        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {}
}
