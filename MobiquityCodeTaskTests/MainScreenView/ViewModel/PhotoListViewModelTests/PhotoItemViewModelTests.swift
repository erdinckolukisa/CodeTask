//
//  PhotoListViewModelTests.swift
//  MobiquityCodeTaskTests
//
//  Created by Erdinc Kolukisa on 9/18/22.
//

import XCTest
@testable import MobiquityCodeTask

class PhotoItemViewModelTests: XCTestCase {
	
	private var sut: PhotoItemViewModel!
	
	override func setUp() {
		super.setUp()
    }

    override func tearDown() {
		super.tearDown()
    }
	
	func test_PhotoItemViewModel_Should_Init_Successfully() {
		let photo = Photo(id: "51202819006", owner: "189674265@N03", secret: "0a908f293c", server: "65535", farm: 1, title: "")
		
		sut = PhotoItemViewModel(photo: photo)
		
		XCTAssertNotNil(sut, "PhotoItemViewModel couldn't initialized")
	}
	
	func test_PhotoItemViewModel_Should_Not_Init_Successfully() {
		let photo = Photo(id: "51202819006", owner: "189674265@N03", secret: nil, server: "65535", farm: 1, title: "")
		
		sut = PhotoItemViewModel(photo: photo)
		
		XCTAssertNil(sut, "PhotoItemViewModel should be nil because of a nil secret")
	}
	
	
	func test_PhotoItemViewModel_ImageUrl() {
		let photo = Photo(id: "51202819006", owner: "189674265@N03", secret: "0a908f293c", server: "65535", farm: 1, title: "")
		sut = PhotoItemViewModel(photo: photo)
		let string = "https://farm1.static.flickr.com/65535/51202819006_0a908f293c.jpg"
		
		XCTAssertNotNil(sut.imageUrl)
		XCTAssertEqual(sut.imageUrl?.absoluteString, string)
	}
}
