//
//  PhotoItemViewModel.swift
//  MobiquityCodeTask
//
//  Created by Erdinc Kolukisa on 9/14/22.
//

import Foundation

final class PhotoItemViewModel {
	
	let id: String
	let title: String
	private let farm: Int
	private let server: String
	private let secret: String
	
	init?(photo: Photo) {
		guard let id = photo.id,
			  let title = photo.title,
			  let farm = photo.farm,
			  let server = photo.server,
			  let secret = photo.secret else {
			return nil
		}
		
		self.id = id
		self.title = title
		self.farm = farm
		self.server = server
		self.secret = secret
	}
	
	var imageUrl: URL? {
		return URL(string: "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg")
	}
}
