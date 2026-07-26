//
//  RemoteDataSource.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import Foundation

public enum RemoteDataSource {
    case movie
}

public protocol RemoteDataSourceProtocol {
    func fetch(movie: RemoteDataSource) async throws -> Movie
}

public final class MovieRemoteDataSource {
    private let apiClient: MoviAPIClientProtocol
    
    public init(apiClient: MoviAPIClientProtocol) {
        self.apiClient = apiClient
    }
}

extension MovieRemoteDataSource: RemoteDataSourceProtocol {
    public func fetch(movie: RemoteDataSource) async throws -> Movie {
        switch movie {
        case .movie:
            try await apiClient.request(MoviesEndpoint.movies)
        }
    }
}
