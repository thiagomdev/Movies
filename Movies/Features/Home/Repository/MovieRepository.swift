//
//  MovieRepository.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import Foundation

protocol MovieRepositoring {
    func fetchMovies() async throws -> [MovieResult]
}

final class MovieRepository {
    private let decoder = JSONDecoder()
    private let dataSource: RemoteDataSourcing
    
    init(dataSource: RemoteDataSourcing) {
        self.dataSource = dataSource
    }
}

extension MovieRepository: MovieRepositoring {
    func fetchMovies() async throws -> [MovieResult] {
        let data = try await dataSource.request()
        let response = try decoder.decode(Movie.self, from: data)
        return response.results
    }
}
