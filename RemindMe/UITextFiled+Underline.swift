//
//  UITextFiled+Underline.swift
//  RemindMe
//
//  Created by Raghu, Reshma L on 9/16/18.
//  Copyright © 2018 Raghu, Reshma L. All rights reserved.
//

import UIKit

extension UITextField {

	func useUnderline() {
		let border = CALayer()
		let borderWidth = CGFloat(1.0)
		border.borderColor = UIColor.lightGray.cgColor
		border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
		border.borderWidth = borderWidth
		self.layer.addSublayer(border)
		self.layer.masksToBounds = true
	}
}
