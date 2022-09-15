//
//  MockAPI.swift
//  MobiquityCodeTaskTests
//
//  Created by Erdinc Kolukisa on 9/15/22.
//

import Foundation
@testable import MobiquityCodeTask

final class MockAPI: Networking {
	var result: Result<PhotoResponse, NetworkErrors> = .failure(.urlError)
	
	func getPhotos(searchText: String, page: Int, completion: @escaping (Result<PhotoResponse, NetworkErrors>) -> Void) {
		completion(result)
	}
	
}
