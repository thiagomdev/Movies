//
//  MovieState.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/18/26.
//

enum MovieState: Equatable, Hashable {
    case loading
    case loaded([MovieResult])
    case failed(String)
}
