//
//  MemoryLeakDetection.swift
//  Movies
//
//  Created by Thiago Monteiro on 6/3/26.
//

import Testing

final class MemoryLeakTracker<T: AnyObject> {
    private weak var instance: T?
    private let sourceLocation: SourceLocation

    init(instance: T, sourceLocation: SourceLocation) {
        self.instance = instance
        self.sourceLocation = sourceLocation
    }
    
    deinit {
        #expect(
            instance == nil,
            """
            💥 Potential Memory Leak Detected!
            ⚠️ Instance of type '\(T.self)' was not deallocated.
            📍 Tracked from: \(sourceLocation.fileName) Line: \(sourceLocation.line) Column: \(sourceLocation.column)
            """,
            sourceLocation: sourceLocation
        )
    }
}

class MemoryLeakTrackingSuite {
    private var trackers = [AnyObject]()
    
    func trackForMemoryLeak<T: AnyObject>(_ instance: T, source: SourceLocation) {
        let tracker = MemoryLeakTracker(instance: instance, sourceLocation: source)
        trackers.append(tracker)
    }
}
