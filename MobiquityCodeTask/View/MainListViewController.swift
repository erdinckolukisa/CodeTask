//
//  MainListViewController.swift
//  MobiquityCodeTask
//
//  Created by Erdinc Kolukisa on 9/13/22.
//

import UIKit

class MainListViewController: UIViewController {
	
	@IBOutlet weak var photosCollectionView: UICollectionView!
	@IBOutlet weak var searchHistoryTableView: UITableView!
	
	var viewModel: MainListViewModel?
	
	private var searchController = UISearchController()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		prepareSearchBar()
		prepareTableView()
		prepareCollectionView()
		
		viewModel?.delegate = self
    }
	
	private func prepareSearchBar() {
		searchController.searchResultsUpdater = self
		navigationItem.searchController = searchController
	}
	
	private func prepareTableView() {
		searchHistoryTableView.layer.cornerRadius = 8.0
		searchHistoryTableView.register(UINib(nibName: SearchTableViewCell.name, bundle: nil), forCellReuseIdentifier: CellIdentifiers.searchCell)
	}
	
	private func prepareCollectionView() {
		let nib = UINib(nibName: PhotoItemCollectionViewCell.name, bundle: nil)
		photosCollectionView.register(nib, forCellWithReuseIdentifier: CellIdentifiers.photoCell)
	}
	
	private func hideSearchResults() {
		shouldHideSearchHistory(true)
		view.isUserInteractionEnabled = true
	}
	
	private func shouldHideSearchHistory(_ isHidden: Bool) {
		let alpha: CGFloat = isHidden ? 0.0 : 1.0
		UIView.animate(withDuration: 0.4) {[weak self] in
			self?.searchHistoryTableView.alpha = alpha
		}
	}
}

// MARK: - MainListViewModelDelegate

extension MainListViewController: MainListViewModelDelegate {
	
	func didFetchPhotos() {
		photosCollectionView.reloadData()
		hideSearchResults()
	}
	
	func didFailFetching(error: NetworkErrors) {
		var errorMessage = ""
		switch error {
			case .responseError(let message):
				errorMessage = message
			default:
				errorMessage = Constants.Errors.genericError
		}
		hideSearchResults()
		showCustomMessageAlert(message: errorMessage, title: "Error") { }
	}
	
	func didUpdateSearchItems() {
		searchHistoryTableView.reloadData()
	}
}

// MARK: - UISearchResultsUpdating

extension MainListViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		guard let searchText = searchController.searchBar.text, searchText.count > 0 else { return }
		
		view.isUserInteractionEnabled = false
		hideSearchResults()
		viewModel?.searchForPhotos(with: searchText)
		shouldHideSearchHistory(false)
	}
}

// MARK: - UITableViewDataSource

extension MainListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView,
				   numberOfRowsInSection section: Int) -> Int {
		return viewModel?.savedItemsCount ?? 0
	}
	
	func tableView(_ tableView: UITableView,
				   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.searchCell) as? SearchTableViewCell {
			let item = viewModel?.getSavedItem(at: indexPath.row)
			cell.displaySavedItem(item)
			
			return cell
		}
		
		return UITableViewCell()
	}
}

// MARK: - UITableViewDelegate

extension MainListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView,
				   didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
		viewModel?.searchForTheSavedItem(at: indexPath.row)
		searchController.searchBar.text = viewModel?.getSavedItem(at: indexPath.row)
		shouldHideSearchHistory(true)
	}
}


// MARK: - UICollectionViewDataSource

extension MainListViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView,
						numberOfItemsInSection section: Int) -> Int {
		return viewModel?.numberOfPhotos ?? 0
	}

	func collectionView(_ collectionView: UICollectionView,
						cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.photoCell,
															  for: indexPath) as? PhotoItemCollectionViewCell {
			photoCell.configureCell(with: viewModel?.getPhotoItem(at: indexPath.row))

			return photoCell
		}

		return PhotoItemCollectionViewCell()
	}
}

// MARK: - UICollectionViewDelegate

extension MainListViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView,
						willDisplay cell: UICollectionViewCell,
						forItemAt indexPath: IndexPath) {
		viewModel?.checkForLoadMore(for: indexPath)
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainListViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = (UIScreen.main.bounds.width - 18)/2
		let height = width * 1.25

		return CGSize(width: width, height: height)
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
	}
}
