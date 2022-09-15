//
//  ThumbImageView.swift
//  MobiquityCodeTask
//
//  Created by Erdinc Kolukisa on 9/15/22.
//

import UIKit

@IBDesignable
class ThumbImageView: UIImageView {
	
	@IBInspectable
	var borderColor: UIColor = UIColor.clear {
		didSet {
			self.layer.borderColor = borderColor.cgColor
		}
	}
	
	@IBInspectable
	var borderWidth: CGFloat = 0.0 {
		didSet {
			self.layer.borderWidth = borderWidth
		}
	}
	
	@IBInspectable
	var cornerRadius: CGFloat = 0.0 {
		didSet {
			self.layer.cornerRadius = cornerRadius
		}
	}
}
