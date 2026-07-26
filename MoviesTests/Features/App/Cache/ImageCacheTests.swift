//
//  ImageCacheTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 7/26/26.
//

import Testing
import Foundation
import UIKit
import os
import Movies

@Suite("🧪 Image Cache", .serialized)
struct ImageCacheTests {
    init() {
        URLProtocolStub.requestHandler = nil
    }

    @Test
    func secondCallForSameURLIsServedFromCache() async throws {
        defer { URLProtocolStub.requestHandler = nil }
        let counter = RequestCounter()
        let pngData = Self.makePNGData()
        URLProtocolStub.requestHandler = { _ in
            counter.increment()
            let response = HTTPURLResponse(
                url: .anyURL,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, pngData)
        }

        let cache = ImageCache()
        let session = Self.makeSession()

        _ = try await cache.image(for: .anyURL, session: session)
        _ = try await cache.image(for: .anyURL, session: session)

        #expect(counter.value == 1)
    }

    @Test
    func concurrentCallsForSameURLAreDeduplicated() async throws {
        defer { URLProtocolStub.requestHandler = nil }
        let counter = RequestCounter()
        let pngData = Self.makePNGData()
        URLProtocolStub.requestHandler = { _ in
            counter.increment()
            let response = HTTPURLResponse(
                url: .anyURL,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, pngData)
        }

        let cache = ImageCache()
        let session = Self.makeSession()

        async let first = cache.image(for: .anyURL, session: session)
        async let second = cache.image(for: .anyURL, session: session)
        _ = try await (first, second)

        #expect(counter.value == 1)
    }
}

extension ImageCacheTests {
    private static func makeSession() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]
        return URLSession(configuration: config)
    }

    nonisolated private static func makePNGData() -> Data {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1))
        let image = renderer.image { ctx in
            UIColor.red.setFill()
            ctx.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        }
        return image.pngData()!
    }
}

private final class RequestCounter: @unchecked Sendable {
    private let lock = OSAllocatedUnfairLock(initialState: 0)

    func increment() {
        lock.withLock { $0 += 1 }
    }

    var value: Int {
        lock.withLock { $0 }
    }
}
