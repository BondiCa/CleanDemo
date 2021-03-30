//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by Amila Fejzic on 11. 3. 2021..
//

import XCTest
@testable import MoviesApp

class MoviesPresenterTests: XCTestCase {

    let moviesPresenter = MoviesPresenter()
    let mockViewController = MockViewController()
    
    override func setUp() {
        super.setUp()
        moviesPresenter.viewController = mockViewController
    }
    
    func test_present_movies() {
        moviesPresenter.presentMovies([])
        XCTAssert(mockViewController.isDisplayMoviesCalled)
    }
}

class MockViewController: MoviesDisplayLogic {
    var isDisplayMoviesCalled: Bool = false
    var isDisplayErrorCalled: Bool = false

    func displayMovies(_ movies: [MovieViewModel]) {
        isDisplayMoviesCalled = true
    }
    
    func displayError(with title: String, message: String?) {
        isDisplayErrorCalled = true
    }
    
    func reset() {
        isDisplayMoviesCalled = false
        isDisplayErrorCalled = false
    }
}
