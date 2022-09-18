//
//  SearchTableViewCell.swift
//  MobiquityCodeTask
//
//  Created by Erdinc Kolukisa on 9/15/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

	@IBOutlet weak var savedItemLabel: UILabel!
	
	func displaySavedItem(_ text: String?) {
		savedItemLabel.text = text
	}
}
