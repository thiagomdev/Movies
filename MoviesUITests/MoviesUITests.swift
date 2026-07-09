//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Thiago Monteiro on 7/8/26.
//

import XCTest

final class MoviesUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func test_appLaunches_showsMoviesNavigationTitle() throws {
        XCTAssertTrue(app.navigationBars["Movies"].waitForExistence(timeout: 15))
    }

    func test_movieRequest_reachesTerminalState() throws {
        let movieList = app.collectionViews["movieList"]
        let errorMessage = app.staticTexts["movieErrorMessage"]

        let reachedTerminalState = NSPredicate { _, _ in
            movieList.exists || errorMessage.exists
        }
        let expectation = XCTNSPredicateExpectation(predicate: reachedTerminalState, object: nil)
        let result = XCTWaiter().wait(for: [expectation], timeout: 15)

        XCTAssertEqual(result, .completed, "Expected the movie request to either load the list or surface an error, but it never left the loading state")
    }

    func test_selectingMovie_navigatesToDetailAndBack() throws {
        let movieList = app.collectionViews["movieList"]
        guard movieList.waitForExistence(timeout: 15) else {
            throw XCTSkip("Movie list did not load — skipping navigation check (see movieErrorMessage for the underlying request failure)")
        }

        let firstCell = movieList.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
        firstCell.tap()

        let detailView = app.scrollViews["movieDetailView"]
        XCTAssertTrue(detailView.waitForExistence(timeout: 5))

        app.navigationBars.buttons.firstMatch.tap()

        XCTAssertTrue(movieList.waitForExistence(timeout: 5))
    }
}
