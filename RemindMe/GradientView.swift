//
//  GradientView.swift
//  RemindMe
//
//  Created by Raghu, Reshma L on 9/10/18.
//  Copyright © 2018 Raghu, Reshma L. All rights reserved.
//

import UIKit

@IBDesignable
final class GradientView: UIView {
	@IBInspectable var startColor: UIColor = UIColor.clear
	@IBInspectable var endColor: UIColor = UIColor.clear

	override func draw(_ rect: CGRect) {
		let gradient: CAGradientLayer = CAGradientLayer()
		gradient.frame = CGRect(x: CGFloat(0),
								y: CGFloat(0),
								width: superview!.frame.size.width,
								height: superview!.frame.size.height)
		gradient.colors = [startColor.cgColor, endColor.cgColor]
		gradient.zPosition = -1
		layer.addSublayer(gradient)
	}
}
