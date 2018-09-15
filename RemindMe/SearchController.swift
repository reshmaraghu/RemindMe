//
//  SearchController.swift
//  RemindMe
//
//  Created by Raghu, Reshma L on 9/15/18.
//  Copyright © 2018 Raghu, Reshma L. All rights reserved.
//

import UIKit
import RAMReel

class SearchController: UIViewController, UICollectionViewDelegate {

	var dataSource: SimplePrefixQueryDataSource!
	var ramReel: RAMReel<RAMCell, RAMTextField, SimplePrefixQueryDataSource>!

	override func viewDidLoad() {
		super.viewDidLoad()
		dataSource = SimplePrefixQueryDataSource(data)
		ramReel = RAMReel(frame: view.bounds, dataSource: dataSource, placeholder: "Start by typing…", attemptToDodgeKeyboard: true) {
			print("Plain:", $0)
		}
		ramReel.hooks.append {
			let r = Array($0.reversed())
			let j = String(r)
			print("Reversed:", j)
		}
		view.addSubview(ramReel.view)
		ramReel.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
	}

	fileprivate let data: [String] = ["Coffee", "HDFC", "Loan"]
}
