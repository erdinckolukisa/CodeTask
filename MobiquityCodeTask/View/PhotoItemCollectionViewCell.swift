//
//  PhotoItemCollectionViewCell.swift
//  MobiquityCodeTask
//
//  Created by Erdinc Kolukisa on 9/14/22.
//

import UIKit
import Kingfisher

class PhotoItemCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var photoImageView: UIImageView!
	
	func configureCell(with model: PhotoItemViewModel?) {
		if let photoModel = model, let url = photoModel.imageUrl {
			photoImageView.kf.setImage(with: url, options: [.transition(.fade(0.25))])
		}
	}
}
