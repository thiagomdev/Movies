//
//  UITestMovieRepositoryFailureStub.swift
//  Movies
//
//  Created by Thiago Monteiro on 7/26/26.
//

#if DEBUG
import Foundation

struct UITestMovieRepositoryFailureStub: MovieRepositoryProtocol {
    func fetchMovies() async throws -> [MovieResult] {
        throw APIError.networkError(URLError(.notConnectedToInternet))
    }
}
#endif
