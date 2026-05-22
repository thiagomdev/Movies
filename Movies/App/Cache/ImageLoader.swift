//
//  ImageLoader.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/4/26.
//

import SwiftUI
import Combine

@MainActor
final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
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
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let uiImage = await Task.detached(priority: .background) {
                UIImage(data: data)
            }.value
            
            if let uiImage {
                ImageCache.shared.setObject(uiImage, forKey: url as NSURL)
                
                await MainActor.run {
                    self.image = uiImage
                }
            }
        } catch {
            print("❌ Image load error:", error)
        }
    }
}
