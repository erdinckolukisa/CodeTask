//
//  MainListViewController.swift
//  MobiquityCodeTask
//
//  Created by Erdinc Kolukisa on 9/13/22.
//

import UIKit

class MainListViewController: UIViewController {
	
	@IBOutlet weak var photosCollectionView: UICollectionView!
	
	var viewModel: MainListViewModel?
	
	private var searchController = UISearchController()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		prepareSearchBar()
		prepareCollectionView()
		
		viewModel?.delegate = self
		viewModel?.searchForPhotos(with: "Ferrari")
    }
	
	private func prepareCollectionView() {
		let nib = UINib(nibName: PhotoItemCollectionViewCell.name, bundle: nil)
		photosCollectionView.register(nib, forCellWithReuseIdentifier: CellIdentifiers.photoCell)
	}
	
	private func prepareSearchBar() {
		searchController.searchResultsUpdater = self
		searchController.searchBar.barStyle = .black
		navigationItem.searchController = searchController
	}
}

// MARK: - MainListViewModelDelegate

extension MainListViewController: MainListViewModelDelegate {
	
	func didFetchPhotos() {
		photosCollectionView.reloadData()
	}
	
	func didFailFetching(error: NetworkErrors) {
		// TODO: IMPLEMENT FAIL
	}
}

// MARK: - UISearchResultsUpdating

extension MainListViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		guard let searchText = searchController.searchBar.text, searchText.count > 0 else { return }
		
		view.isUserInteractionEnabled = false
		viewModel?.searchForPhotos(with: searchText)
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
