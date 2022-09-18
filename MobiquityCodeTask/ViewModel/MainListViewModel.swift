//
//  MainListViewModel.swift
//  MobiquityCodeTask
//
//  Created by Erdinc Kolukisa on 9/13/22.
//

import Foundation

protocol MainListViewModelDelegate: AnyObject {
	func didFetchPhotos()
	func didFailFetching(error: NetworkErrors)
	func didUpdateSearchItems()
}

final class MainListViewModel {
	
	weak var delegate: MainListViewModelDelegate?
	private let network: Networking
	private let searchManager: SearchProviding
	
	private var searchText = ""
	private var pageNumber = 1
	private var workItem: DispatchWorkItem?
	private var photos: [PhotoItemViewModel] = [PhotoItemViewModel]()
	private var isLoading = false
	
	init(network: Networking, searchProvider: SearchProviding) {
		self.network = network
		self.searchManager = searchProvider
	}
	
	var numberOfPhotos: Int {
		return photos.count
	}
	
	var savedItemsCount: Int {
		return searchManager.itemCount
	}
	
	private func fetchPhotosFor(searchText: String) {
		if !isLoading {
			isLoading = true
			network.getPhotos(searchText: searchText, page: pageNumber) { [weak self] result in
				guard let self = self else { return }
				
				switch result {
					case .success(let response):
						self.pageNumber += 1
						let photoViewModels = response.photos?.photo?.compactMap{ PhotoItemViewModel(photo: $0) }
						self.photos.append(contentsOf: photoViewModels ?? [])
						self.delegate?.didFetchPhotos()
					case .failure(let error):
						self.delegate?.didFailFetching(error: error)
				}
				self.isLoading = false
			}
		}
	}
	
	func searchForPhotos(with text: String) {
		workItem?.cancel()
		workItem = DispatchWorkItem { [weak self] in
			guard let self = self else { return }
			
			self.photos.removeAll()
			self.searchText = text
			self.fetchPhotosFor(searchText: text)
			self.searchManager.addSearchKey(text)
			self.delegate?.didUpdateSearchItems()
		}
		
		guard let workItem = workItem else { return }

		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: workItem)
	}
	
	func checkForLoadMore(for indexPath: IndexPath) {
		if (indexPath.row == (numberOfPhotos - 2)) {
			fetchPhotosFor(searchText: searchText)
		}
	}
	
	func getPhotoItem(at index: Int) -> PhotoItemViewModel? {
		return photos[index]
	}
	
	func getSavedItem(at index: Int) -> String? {
		return searchManager.getSavedItem(at: index)
	}
	
	func searchForTheSavedItem(at index: Int) {
		if let savedItemTitle = getSavedItem(at: index) {
			searchForPhotos(with: savedItemTitle)
		}
	}
}
