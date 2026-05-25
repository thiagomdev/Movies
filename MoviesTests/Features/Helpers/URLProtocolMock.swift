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
        print("===> DEBUG: 🎯 startLoading chamado para: \(request.url?.absoluteString ?? "nil")")
        
        guard let handler = URLProtocolMock.requestHandler else {
            print("===> DEBUG: ❌ requestHandler está NIL")
            return
        }
        print("===> DEBUG: ✅ requestHandler existe, executando...")
        
        do {
            let (response, data) = try handler(request)
            print("===> DEBUG: ✅ handler retornou. Status: \(response.statusCode), bytes: \(data.count)")
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
            print("===> DEBUG: ✅ finalizou loading")
        } catch {
            print("===> DEBUG: ❌ handler lançou erro: \(error)")
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
}

extension URLProtocolMock {
    override func stopLoading() {
        //: TODO
    }
}
