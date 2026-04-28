//
//  DataSource.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import Foundation

protocol RemoteDataSourcing {
    func request() async throws -> Data
}

final class RemoteDataSource {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
}

extension RemoteDataSource: RemoteDataSourcing {
    func request() async throws -> Data {
        if let url = URL(string: "https://api.themoviedb.org/3/discover/movie") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = [
                "accept": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZjk0NDk4ZDA0ZGFjZDFjZjk2NjQ4YmIxN2NlYmM2NyIsIm5iZiI6MTY5MzQwMDczNS44NjA5OTk4LCJzdWIiOiI2NGVmM2U5Zjk3YTRlNjAwYzQ4NjJjZGIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.AAAJG3OLN5csc3p4V0MJyNwmMpGbPJcIIU-SwYWDrv8"
            ]
            let (data, response) = try await session.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                if(200..<300).contains(httpResponse.statusCode) {
                    return data
                }
            }
        }
        return Data()
    }
}
