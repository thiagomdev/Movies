//
//  CachedAsyncImage.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/4/26.
//

import SwiftUI

struct CachedAsyncImage: View {

    @StateObject private var loader: ImageLoader

    init(url: URL?) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        ZStack {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                ProgressView()
            }
        }
        .task {
            await loader.load()
        }
    }
}
