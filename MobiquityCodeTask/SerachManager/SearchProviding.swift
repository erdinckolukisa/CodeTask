//
//  SearchManaging.swift
//  MobiquityCodeTask
//
//  Created by Erdinc Kolukisa on 9/13/22.
//

import Foundation

protocol SearchProviding {
	var itemCount: Int { get }
	func addSearchKey(_ searchItem: String)
	func getSavedItem(at index: Int) -> String?
}
