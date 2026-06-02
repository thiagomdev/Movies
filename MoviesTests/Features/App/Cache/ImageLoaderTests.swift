//
//  ImageLoaderTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 6/2/26.
//

import Testing
import Foundation
import UIKit
@testable import Movies

@MainActor
@Suite("🧪 Image Loader", .serialized)
struct ImageLoaderTests {
    init() {
        URLProtocolStub.requestHandler = nil
    }

    @Test
    func loadWithNilURLKeepsImageNil() async {
        let sut = ImageLoader(url: nil, session: makeSession())

        await sut.load()

        #expect(sut.image == nil)
    }

    @Test
    func loadWithValidImageDataSetsImage() async {
        defer { URLProtocolStub.requestHandler = nil }
        let pngData = makePNGData()
        URLProtocolStub.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: .anyURL,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, pngData)
        }

        let sut = ImageLoader(url: .anyURL, session: makeSession())

        await sut.load()

        #expect(sut.image != nil)
    }

    @Test
    func loadWithInvalidImageDataKeepsImageNil() async {
        defer { URLProtocolStub.requestHandler = nil }
        URLProtocolStub.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: .anyURL,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data("not an image".utf8))
        }

        let sut = ImageLoader(url: .anyURL, session: makeSession())

        await sut.load()

        #expect(sut.image == nil)
    }

    @Test
    func loadWithNetworkErrorKeepsImageNil() async {
        defer { URLProtocolStub.requestHandler = nil }
        URLProtocolStub.requestHandler = { _ in
            throw URLError(.notConnectedToInternet)
        }

        let sut = ImageLoader(url: .anyURL, session: makeSession())

        await sut.load()

        #expect(sut.image == nil)
    }
}

extension ImageLoaderTests {
    private func makeSession() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]
        return URLSession(configuration: config)
    }

    private func makePNGData() -> Data {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1))
        let image = renderer.image { ctx in
            UIColor.red.setFill()
            ctx.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        }
        return image.pngData()!
    }
}
