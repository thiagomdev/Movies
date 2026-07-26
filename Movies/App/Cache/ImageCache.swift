//
//  ImageCache.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/4/26.
//

import UIKit

public actor ImageCache {
    public static let shared = ImageCache()

    private var cachedImages: [URL: UIImage] = [:]
    private var inFlightTasks: [URL: Task<UIImage, Error>] = [:]

    public init() {}
}

extension ImageCache {
    public func image(for url: URL, session: URLSession) async throws -> UIImage {
        if let cachedImage = cachedImages[url] {
            return cachedImage
        }

        if let inFlightTask = inFlightTasks[url] {
            return try await inFlightTask.value
        }

        let task = Task<UIImage, Error> {
            let (data, _) = try await session.data(from: url)
            guard let image = UIImage(data: data) else {
                throw APIError.invalidResponse
            }
            return image
        }
        inFlightTasks[url] = task

        do {
            let image = try await task.value
            cachedImages[url] = image
            inFlightTasks[url] = nil
            return image
        } catch {
            inFlightTasks[url] = nil
            throw error
        }
    }
}
