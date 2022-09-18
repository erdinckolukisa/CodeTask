//
//  MockSearchProvider.swift
//  MobiquityCodeTaskTests
//
//  Created by Erdinc Kolukisa on 9/15/22.
//

import Foundation
@testable import MobiquityCodeTask

final class MockSearchProvider: SearchProviding {
	var itemCount: Int {
		return 0
	}
	
	func getSavedItem(at index: Int) -> String? {
		return "Item"
	}
	
	func addSearchKey(_ searchItem: String) {
		// NO-OP
	}
}
