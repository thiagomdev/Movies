//
//  ImageLoader.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/4/26.
//

import SwiftUI

@MainActor
@Observable
public final class ImageLoader {
    public var image: UIImage?

    private let url: URL?
    private let session: URLSession
    private let cache: ImageCache

    public init(url: URL?, session: URLSession = .shared, cache: ImageCache = .shared) {
        self.url = url
        self.session = session
        self.cache = cache
    }
}

extension ImageLoader {
    public func load() async {
        guard let url else { return }
        do {
            image = try await cache.image(for: url, session: session)
        } catch {
            print(error)
        }
    }
}
