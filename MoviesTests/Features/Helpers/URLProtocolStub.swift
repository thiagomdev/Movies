//
//  URLProtocolMock.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/19/26.
//

import Foundation

final class URLProtocolStub: URLProtocol, @unchecked Sendable {
     nonisolated(unsafe) static var requestHandler: ((URLRequest) throws -> (URLResponse, Data))?
}

extension URLProtocolStub {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
}

extension URLProtocolStub {
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
}

extension URLProtocolStub {
    override func startLoading() {        
        guard let handler = URLProtocolStub.requestHandler else {
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

extension URLProtocolStub {
    override func stopLoading() {
        //: TODO
    }
}
