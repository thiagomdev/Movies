//
//  SplashView.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/28/26.
//

import SwiftUI

struct SplashView: View {
    @Binding var isActive: Bool
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            Image("appstore")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}
