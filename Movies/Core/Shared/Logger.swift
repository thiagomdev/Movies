//
//  Logger.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/21/26.
//

import Foundation

enum Logger {
    static func log(request: URLRequest?, response: URLResponse?, data: Data?, error: Error?, verbose: Bool =  true) {
        print("-------------------- 🚀 START OF REQUEST 🚀 --------------------")
        if let url = request?.url {
            print("===> DEBUG: REQUEST URL: \(url.absoluteString)")
        }
        
        if let method = request?.httpMethod {
            print("===> DEBUG: HTTP METHOD: \(method)")
        }
        
        if verbose, let headers = request?.allHTTPHeaderFields {
            print("===> DEBUG: HEADERS: \(headers)")
        }
        
        if verbose, let body = request?.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("===> DEBUG: BODY STRING: \(bodyString)")
        }
        
        if let httpresponse = response as? HTTPURLResponse {
            let statusCode = httpresponse.statusCode
            let statusIcon = (200..<300).contains(statusCode) ? "✅" : "❌"
            print("===> DEBUG: STATUS CODE: \(statusCode) \(statusIcon)")
        } else if let error {
            print("===> 🛑 DEBUG: Error: \(error.localizedDescription)")
        } else {
            print("===> 🛑 DEBUG: Error: Not RESPONSE and no ERROR")
        }
        
        if verbose, let headers = (response as? HTTPURLResponse)?.allHeaderFields as? [String: Any] {
            print("===> DEBUG: RESPONSE HEADERS: \(headers)")
        }
        
        if let data = data {
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("===> DEBUG: JSON RESPONSE: \(jsonString)")
                }
            } catch let serializationError {
                print("===> DEBUG: Failed to serialize JSON: \(serializationError)")
            }
        }
        print("-------------------- 🚀 END OF REQUEST 🚀 --------------------")
    }
    
    static func logError(error: Error, url: URL?) {
        print("-------------------- ❌ END OF REQUEST ❌ --------------------")
        print("===> DEBUG: Failed URL: \(String(describing: url))")
        print("===> DEBUG: Error: \(error.localizedDescription)")
        print("-------------------- ❌ END OF ERROR ❌ ----------------------")
    }
}
