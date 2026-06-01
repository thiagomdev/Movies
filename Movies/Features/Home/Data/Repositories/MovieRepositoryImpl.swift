//
//  MovieRepository.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import Foundation

final class MovieRepositoryImpl {
    private let dataSource: RemoteDataSourceProtocol
    
    init(dataSource: RemoteDataSourceProtocol) {
        self.dataSource = dataSource
    }
}

extension MovieRepositoryImpl: MovieRepositoryProtocol {
    func fetchMovies() async throws -> [MovieResult] {
        return try await dataSource.fetchMovies().results
    }
}
