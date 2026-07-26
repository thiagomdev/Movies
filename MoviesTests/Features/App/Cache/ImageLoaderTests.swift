//
//  ImageLoaderTests.swift
//  MoviesTests
//
//  Created by Thiago Monteiro on 6/2/26.
//

import Testing
import Foundation
import UIKit
import Movies

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

    @Test(arguments: [makePNGData(), makeJPEGData()])
    func loadWithValidImageDataSetsImage(payload: Data) async {
        defer { URLProtocolStub.requestHandler = nil }
        URLProtocolStub.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: .anyURL,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, payload)
        }

        let sut = ImageLoader(url: .anyURL, session: makeSession(), cache: ImageCache())

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

        let sut = ImageLoader(url: .anyURL, session: makeSession(), cache: ImageCache())

        await sut.load()

        #expect(sut.image == nil)
    }

    @Test
    func loadWithNetworkErrorKeepsImageNil() async {
        defer { URLProtocolStub.requestHandler = nil }
        URLProtocolStub.requestHandler = { _ in
            throw URLError(.notConnectedToInternet)
        }

        let sut = ImageLoader(url: .anyURL, session: makeSession(), cache: ImageCache())

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

    nonisolated
    private static func makePNGData() -> Data {
        makeImage().pngData()!
    }

    nonisolated
    private static func makeJPEGData() -> Data {
        makeImage().jpegData(compressionQuality: 1.0)!
    }

    nonisolated
    private static func makeImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1))
        return renderer.image { ctx in
            UIColor.red.setFill()
            ctx.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        }
    }
}
