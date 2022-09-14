//
//  Networking.swift
//  MobiquityCodeTask
//
//  Created by Erdinc Kolukisa on 9/13/22.
//

import Foundation

protocol Networking {
	func getPhotos(searchText: String, page: Int, completion: @escaping(Result<PhotoResponse, NetworkErrors>) -> Void)
}
