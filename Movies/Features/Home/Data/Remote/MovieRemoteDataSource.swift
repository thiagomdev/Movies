//
//  RemoteDataSource.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import Foundation

enum RemoteDataSource {
    case movie
}

protocol RemoteDataSourceProtocol {
    func fetch(movie: RemoteDataSource) async throws -> Movie
}

final class MovieRemoteDataSource {
    private let apiClient: MoviAPIClientProtocol
    
    init(apiClient: MoviAPIClientProtocol) {
        self.apiClient = apiClient
    }
}

extension MovieRemoteDataSource: RemoteDataSourceProtocol {
    func fetch(movie: RemoteDataSource) async throws -> Movie {
        switch movie {
        case .movie:
            try await apiClient.request(MoviesEndpoint.movies)
        }
    }
}
