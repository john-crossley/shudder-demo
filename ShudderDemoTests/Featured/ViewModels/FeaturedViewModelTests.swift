//
//  FeaturedViewModelTests.swift
//  ShudderDemoTests
//
//  Created by John Crossley on 30/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import XCTest
@testable import ShudderDemo

class MockMovieService: MovieService {

    var shouldReturnCallback = true
    var shouldError = false

    var sections = [
        Section(type: .hero, category: "Horror", query: "horror movies", limit: 10),
        Section(type: .collection, category: "Thriller", query: "thriller movies", limit: 8),
        Section(type: .collection, category: "Comedy", query: "comedy movies", limit: 6),
    ]

    func featured(callback: @escaping (Result<[Section], MovieServiceError>) -> Void) {
        guard shouldReturnCallback else { return }

        if shouldError {
            callback(.failure(.dataNotFound))
        } else {
            callback(.success(sections))
        }
    }
}

class MockFeaturedViewModelDelegate: FeaturedViewModelDelegate {

    var viewModels: [SectionViewModel] = []
    var didError = false

    var callback: (() -> Void)?

    func didUpdate(state: FeaturedViewModel.State) {

        if case .loaded(let loaded) = state {
            self.viewModels = loaded
            callback?()
        }

        if case .error = state {
            self.didError = true
            callback?()
        }
    }

}

class FeaturedViewModelTests: XCTestCase {

    func testItCanParseSectionsIntoSectionViewModels() {

        var exp: XCTestExpectation? = expectation(description: "didReturnSectionViewModels")

        let mockDelegate = MockFeaturedViewModelDelegate()

        let viewModel = FeaturedViewModel(service: MockMovieService())
        viewModel.delegate = mockDelegate

        mockDelegate.callback = {
            exp?.fulfill()
            exp = nil
        }

        viewModel.fetch()

        wait(for: [exp!], timeout: 5)
        XCTAssertEqual(mockDelegate.viewModels.count, 3)

        XCTAssertEqual(mockDelegate.viewModels[0].category, "Horror")
        XCTAssertEqual(mockDelegate.viewModels[0].type, SectionType.hero)
    }

    func testItCanReportError() {
        var exp: XCTestExpectation? = expectation(description: "didReturnSectionViewModels")

        let mockDelegate = MockFeaturedViewModelDelegate()
        let mockService = MockMovieService()
        mockService.shouldError = true

        let viewModel = FeaturedViewModel(service: mockService)
        viewModel.delegate = mockDelegate

        mockDelegate.callback = {
            exp?.fulfill()
            exp = nil
        }

        viewModel.fetch()

        wait(for: [exp!], timeout: 5)

        XCTAssertTrue(mockDelegate.didError)
    }
}
