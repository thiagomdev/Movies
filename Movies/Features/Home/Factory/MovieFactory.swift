//
//  MovieFactory.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import Foundation
import SwiftUI

public enum MovieFactory {
    @MainActor
    public static func make() -> some View {
        let repository = makeRepository()
        let useCase = MovieUseCase(repository: repository)
        let store = MovieStore(useCase: useCase)
        let view = MovieView(store: store)
        return view
    }
}

extension MovieFactory {
    private static func makeRepository() -> MovieRepositoryProtocol {
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("UITestingFailure") {
            return UITestMovieRepositoryFailureStub()
        }
        if ProcessInfo.processInfo.arguments.contains("UITesting") {
            return UITestMovieRepositoryStub()
        }
        #endif
        let apiClient = MovieAPIClient(session: .shared)
        let dataSource = MovieRemoteDataSource(apiClient: apiClient)
        return MovieRepositoryImpl(dataSource: dataSource)
    }
}
