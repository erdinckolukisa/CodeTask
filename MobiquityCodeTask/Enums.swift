//
//  Enums.swift
//  MobiquityCodeTask
//
//  Created by Erdinc Kolukisa on 9/13/22.
//

import Foundation

enum Constants {
	
	static let savedItemsKey = "searchItems"
	static let storyboardName = "Main"
	
	enum Errors {
		static let genericError = "An error occured. Please try again later."
	}
	
	enum ApiRequest {
		static let apiKey = "XXX"
		static let method = "flickr.photos.search"
	}
}

enum NetworkErrors: Error {
	case urlError
	case decodingError
	case unknownResponseStatus
	case responseError(message: String)
}

enum CellIdentifiers {
	static let photoCell = "photoItemCollectionViewCell"
	static let searchCell = "searchCell"
}
