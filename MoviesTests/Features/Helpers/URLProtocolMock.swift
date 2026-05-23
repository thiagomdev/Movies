//
//  URLProtocolMock.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/19/26.
//

import Foundation

final class URLProtocolMock: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    
    override func startLoading() {
        print("===> 🎯 startLoading chamado para: \(request.url?.absoluteString ?? "nil")")
        
        guard let handler = URLProtocolMock.requestHandler else {
            print("===> ❌ requestHandler está NIL")
            return
        }
        print("===> ✅ requestHandler existe, executando...")
        
        do {
            let (response, data) = try handler(request)
            print("===> ✅ handler retornou. Status: \(response.statusCode), bytes: \(data.count)")
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
            print("===> ✅ finalizou loading")
        } catch {
            print("===> ❌ handler lançou erro: \(error)")
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {}
}
