//
//  MoviesApp.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import SwiftUI

@main
struct MoviesApp: App {
    var body: some Scene {
        WindowGroup {
            MovieFactory.make()
        }
    }
}
