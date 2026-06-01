//
//  URLProtocolMock.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/19/26.
//

import Foundation

final class URLProtocolMock: URLProtocol, @unchecked Sendable {
     nonisolated(unsafe) static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
}

extension URLProtocolMock {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
}

extension URLProtocolMock {
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
}

extension URLProtocolMock {
    override func startLoading() {        
        guard let handler = URLProtocolMock.requestHandler else {
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
}

extension URLProtocolMock {
    override func stopLoading() {
        //: TODO
    }
}
