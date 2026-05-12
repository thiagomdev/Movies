//
//  RemoteDataSource.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import Foundation

protocol RemoteDataSourceProtocol {
    func fetchMovies() async throws -> Movie
}

final class MovieRemoteDataSource {
    private let apiClient: MovieAPIClient
    
    init(apiClient: MovieAPIClient) {
        self.apiClient = apiClient
    }
}

extension MovieRemoteDataSource: RemoteDataSourceProtocol {
    func fetchMovies() async throws -> Movie {
        try await apiClient.request(MovieEndpoint.endpoint)
    }
}
