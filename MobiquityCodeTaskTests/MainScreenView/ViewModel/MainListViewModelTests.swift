//
//  MainListViewModelTests.swift
//  MobiquityCodeTaskTests
//
//  Created by Erdinc Kolukisa on 9/15/22.
//

import XCTest
@testable import MobiquityCodeTask

class MainListViewModelTests: XCTestCase {

	var network: MockAPI!
	var provider: MockSearchProvider!
	var sut: MainListViewModel!
	var expectation: XCTestExpectation?
	
    override func setUp() {
		super.setUp()
		
		network = MockAPI()
		provider = MockSearchProvider()
		sut = MainListViewModel(network: network, searchProvider: provider)
	}

    override func tearDown() {
		network = nil
		sut = nil
		
		super.tearDown()
	}
	
	func test_MainListViewModel_FailingNetworkCall_NetworkCallShouldFail() {
		fetchPhotos()
		
		XCTAssertEqual(sut.numberOfPhotos, 0, "Photos array in MainListViewModel should be empty")
	}
	
	func test_MainListViewModel_NumberOfPhotos_ShouldReturnFive() {
		network.result = .success(PhotoResponse.getDummyPhotos())
		fetchPhotos()

		XCTAssertEqual(sut.numberOfPhotos, 5, "Photos array in MainListViewModel should has 5 items")
	}
	
	func test_MainListViewModel_CheckForLoadMore_ShouldntLoadMore() {
		network.result = .success(PhotoResponse.getDummyPhotos())
		fetchPhotos()
		let indexPath = IndexPath(row: 0, section: 0)
		
		sut.checkForLoadMore(for: indexPath)
		
		XCTAssertEqual(sut.numberOfPhotos, 5)
	}
	
	func test_MainListViewModel_CheckForLoadMore_ShouldLoadMore() {
		network.result = .success(PhotoResponse.getDummyPhotos())
		fetchPhotos()
		let indexPath = IndexPath(row: 3, section: 0)

		sut.checkForLoadMore(for: indexPath)

		XCTAssertEqual(sut.numberOfPhotos, 10)
	}
}

extension MainListViewModelTests: MainListViewModelDelegate {
	func fetchPhotos() {
		sut.delegate = self
		expectation = expectation(description: "Fetch photo expectation")
		sut.searchForPhotos(with: "ferrari")
		waitForExpectations(timeout: 5)
	}
	
	func didFetchPhotos() {
		expectation?.fulfill()
		expectation = nil
	}
	
	func didFailFetching(error: NetworkErrors) {
		expectation?.fulfill()
		expectation = nil
	}
}
