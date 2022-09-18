//
//  WebAPI.swift
//  MobiquityCodeTask
//
//  Created by Erdinc Kolukisa on 9/13/22.
//

import Foundation

final class WebAPI: Networking {
	
	private var urlComponents = URLComponents()
	
	init() {
		urlComponents.scheme = "https"
		urlComponents.host = "api.flickr.com"
		urlComponents.path = "/services/rest/"
	}
	
	private func createQueryItems(searchText: String, pageNumber: Int) -> [URLQueryItem] {
		var queryItems = [URLQueryItem]()
		
		queryItems.append(URLQueryItem(name: "method", value: Constants.ApiRequest.method))
		queryItems.append(URLQueryItem(name: "api_key", value: Constants.ApiRequest.apiKey))
		queryItems.append(URLQueryItem(name: "format", value: "json"))
		queryItems.append(URLQueryItem(name: "nojsoncallback", value: "1"))
		queryItems.append(URLQueryItem(name: "text", value: searchText))
		queryItems.append(URLQueryItem(name: "page", value: "\(pageNumber)"))
		
		return queryItems
	}
	
	func getPhotos(searchText: String, page: Int, completion: @escaping(Result<PhotoResponse, NetworkErrors>) -> Void) {
		urlComponents.queryItems = createQueryItems(searchText: searchText, pageNumber: page)
		guard let url = urlComponents.url else { return }
		let request = URLRequest(url: url)
		sendData(request: request) { result in
			completion(result)
		}
	}
	
	
	private func sendData<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, NetworkErrors>) -> ()) {
		URLSession.shared.dataTask(with: request) { (data, response, error) in
			DispatchQueue.main.async {
				if (error != nil) {
					completion(.failure(.responseError(message: error?.localizedDescription ?? Constants.Errors.genericError)))
					return
				}
				
				guard let httpResponse = response as? HTTPURLResponse else {
					completion(.failure(.responseError(message: error?.localizedDescription ?? Constants.Errors.genericError)))
					return
				}
				
				guard let data = data else {
					completion(.failure(.responseError(message: error?.localizedDescription ?? Constants.Errors.genericError)))
					return
				}
				
				do {
					if (200..<300).contains(httpResponse.statusCode) {
						let decoder = JSONDecoder()
						decoder.keyDecodingStrategy = .convertFromSnakeCase
						let model = try decoder.decode(T.self, from: data)
						completion(.success(model))
						
					} else {
						completion(.failure(.unknownResponseStatus))
					}
				} catch {
					print(error)
					completion(.failure(.decodingError))
				}
			}
		}.resume()
	}
}
