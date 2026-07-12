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

    public init(url: URL?, session: URLSession = .shared) {
        self.url = url
        self.session = session
    }
}

extension ImageLoader {
    public func load() async {
        guard let url else { return }
        await fetchAndCacheImage(url)
    }
}

extension ImageLoader {
    private func fetchAndCacheImage(_ url: URL) async {
         do {
             try await session(url)
         } catch {
             print(error)
         }
     }
}

extension ImageLoader {
    private func session(_ url: URL) async throws {
        let (data, _) = try await session.data(from: url)
        guard let image = UIImage(data: data) else {
            throw APIError.invalidResponse
        }
        ImageCache.shared.setObject(image, forKey: url as NSURL)
        self.image = image
    }
}
