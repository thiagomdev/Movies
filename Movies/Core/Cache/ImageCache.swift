//
//  ImageCache.swift
//  Movies
//
//  Created by Thiago Monteiro on 5/4/26.
//

import SwiftUI
import Foundation

final class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()
}
