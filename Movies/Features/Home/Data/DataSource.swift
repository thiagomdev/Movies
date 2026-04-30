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
    private let urlString: String = "https://api.themoviedb.org/3/discover/movie"
    
    init(session: URLSession) {
        self.session = session
    }
}

extension RemoteDataSource: RemoteDataSourcing {
    func request() async throws -> Data {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
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
