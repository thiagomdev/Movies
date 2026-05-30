//
//  ImageLoader.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/4/26.
//

import SwiftUI

@MainActor
@Observable
final class ImageLoader {
    var image: UIImage?
    
    private let url: URL?
    
    init (url: URL?) {
        self.url = url
    }
}

extension ImageLoader {
    func load() async {
        guard let url else { return }
        
        if let cached = ImageCache.shared.object(forKey: url as NSURL) {
            self.image = cached
            return
        }
        
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
    
    private func session(_ url: URL) async throws {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw URLError(.badServerResponse)
        }
        ImageCache.shared.setObject(image, forKey: url as NSURL)
        self.image = image
    }
}
