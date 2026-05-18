//
//  MovieFactory.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import SwiftUI

enum MovieFactory {
    static func make() -> some View {
        let apiClient = MovieAPIClient(session: .shared)
        let dataSource = MovieRemoteDataSource(apiClient: apiClient)
        let repository = MovieRepositoryImpl(dataSource: dataSource)
        let useCase = MovieUseCase(repository: repository)
        let store = MovieStore(useCase: useCase)
        let view = MovieView(store: store)
        return view
    }
}
