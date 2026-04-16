//
//  MovieFactory.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import SwiftUI

enum MovieFactory {
    static func make() -> some View {
        let dataSource = RemoteDataSource(session: .shared)
        let repository = MovieRepository(dataSource: dataSource)
        let useCase = MovieUseCase(repository: repository)
        let viewModel = MovieViewModel(useCase: useCase)
        let view = MovieView(viewModel: viewModel)
        return view
    }
}
