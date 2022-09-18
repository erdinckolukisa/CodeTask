//
//  StubAPI.swift
//  MobiquityCodeTask
//
//  Created by Erdinc Kolukisa on 9/18/22.
//

import Foundation

final class StubAPI: Networking {
	func getPhotos(searchText: String, page: Int, completion: @escaping (Result<PhotoResponse, NetworkErrors>) -> Void) {
		loadFromStubFile(fileName: "stub") { response in
			completion(response)
		}
	}
	
	private func loadFromStubFile<T: Decodable>(fileName: String, completion: @escaping (Result<T, NetworkErrors>) -> ()) {
		DispatchQueue.main.async {
			if let jsonUrl = Bundle.main.url(forResource: fileName, withExtension: "json") {
				do {
					let jsonData = try Data(contentsOf: jsonUrl)
					let decoder = JSONDecoder()
					let object = try decoder.decode(T.self, from: jsonData)
					completion(.success(object))
				} catch {
					completion(.failure(.decodingError))
				}
			} else {
				completion(.failure(.urlError))
			}
		}
	}
}
