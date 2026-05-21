//
//  SplashView.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/28/26.
//

import SwiftUI

struct SplashView: View {
    @Binding var isActive: Bool
    @State private var cancellableTask: Task<Void, Never>?
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            Image("appstore")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            Task { await sleep() }
            isActive.toggle()
        }
        .onDisappear {
            cancel()
        }
    }
}

extension SplashView {
    private func cancel() {
        cancellableTask?.cancel()
        cancellableTask = nil
    }
    
    private func sleep() async {
        cancellableTask?.cancel()
        cancellableTask = Task { @MainActor in
            do {
                try await Task.sleep(nanoseconds: 3_000_000_000)
                isActive.toggle()
            } catch {
                print(error)
            }
        }
    }
}
