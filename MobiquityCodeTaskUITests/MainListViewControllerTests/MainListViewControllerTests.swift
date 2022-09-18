//
//  MainListViewControllerTests.swift
//  MobiquityCodeTaskUITests
//
//  Created by Erdinc Kolukisa on 9/18/22.
//

import XCTest

class MainListViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
		XCUIDevice.shared.orientation = .portrait
    }

    override func tearDownWithError() throws { }
	
	func test_MainListViewController_Search_Feature(){
		let app = XCUIApplication()
		app.launch()
		
		let searchTextField = XCUIApplication().navigationBars["Flickr"].searchFields["Search"]
		XCTAssertTrue(searchTextField.exists)
		
		searchTextField.tap()
		searchTextField.typeText("Ferrari")
		app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
		sleep(10)
		let count = XCUIApplication().collectionViews.element.children(matching: .cell).count
		XCTAssertTrue(count > 0, "Count failed")
	}
}
