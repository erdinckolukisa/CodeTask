//
//  Photo.swift
//  MobiquityCodeTask
//
//  Created by Erdinc Kolukisa on 9/13/22.
//

import Foundation

struct PhotoResponse: Codable {
	let stat: String?
	let photos: Photos?
}

struct Photos: Codable {
	let page: Int?
	let pages: Int?
	let total: Int?
	let photo: [Photo]?
}

struct Photo: Codable {
	let id: String?
	let owner: String?
	let secret: String?
	let server: String?
	let farm: Int?
	let title: String?
}

extension PhotoResponse {
	static func getDummyPhotos() -> PhotoResponse {
		return PhotoResponse(stat: "status Ok", photos: Photos(page: 1, pages: 100, total: 10000, photo: [
			Photo(id: "51202819006", owner: "189674265@N03", secret: "0a908f293c", server: "65535", farm: 1, title: ""),
			Photo(id: "51203375054", owner: "89892328@N02", secret: "b814281e35", server: "0", farm: 1, title: "red patent low heels and cuban nylons - shoeplay"),
			Photo(id: "51201733542", owner: "154180395@N03", secret: "74489e286a", server: "65535", farm: 1, title: "New Kittens"),
			Photo(id: "51203021694", owner: "48986945@N03", secret: "0f273db557", server: "65535", farm: 1, title: "Eva and Baz 2015"),
			Photo(id: "51202446668", owner: "42534216@N03", secret: "1e29ed16e0", server: "65535", farm: 1, title: "Ariel"),
			
		]))
	}
}
