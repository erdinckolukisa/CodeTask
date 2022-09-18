//
//  SearchManager.swift
//  MobiquityCodeTask
//
//  Created by Erdinc Kolukisa on 9/13/22.
//

import Foundation

final class SearchProvider {
	
	private var savedSearchItems = [String]()
	
	init() {
		guard let savedObjects = UserDefaults.standard.value(forKey: Constants.savedItemsKey) as? [String] else { return }
		savedSearchItems = savedObjects
	}
	
	private func isSearchItemExist(_ searchItem: String) -> Bool {
		return savedSearchItems.contains(searchItem)
	}
	
	private func updateSearchSource(for searchItem: String) {
		if let foundIndex  = savedSearchItems.firstIndex(where: { $0 == searchItem }), foundIndex >= 0 {
			savedSearchItems.remove(at: foundIndex)
			savedSearchItems.insert(searchItem, at: 0)
		}
	}
	
	private func save() {
		UserDefaults.standard.setValue(savedSearchItems, forKey: Constants.savedItemsKey)
	}
}

extension SearchProvider: SearchProviding {
	
	var itemCount: Int {
		return savedSearchItems.count
	}
	
	func addSearchKey(_ searchItem: String) {
		if isSearchItemExist(searchItem) {
			updateSearchSource(for: searchItem)
		} else {
			savedSearchItems.append(searchItem)
		}
		
		save()
	}
	
	func getSavedItem(at index: Int) -> String? {
		return savedSearchItems[index]
	}
}
