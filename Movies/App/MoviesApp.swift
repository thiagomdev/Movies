//
//  MoviesApp.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/15/26.
//

import SwiftUI

@main
struct MoviesApp: App {
    @State private var isActive = false
    
    var body: some Scene {
        WindowGroup {
            if isActive {
                MovieFactory.make()
            } else {
                SplashView(isActive: $isActive)
            }
        }
    }
}
