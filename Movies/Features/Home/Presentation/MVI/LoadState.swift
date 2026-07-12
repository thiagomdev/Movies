//
//  LoadState.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/18/26.
//

public enum LoadState<Value: Equatable>: Equatable {
    case loading
    case loaded(Value)
    case failed(APIError)
}
