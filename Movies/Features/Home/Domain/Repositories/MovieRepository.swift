//
//  MovieRepository.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/12/26.
//

protocol MovieRepositoryProtocol {
    func fetchMovies() async throws -> [MovieResult]
}
