//
//  FirstVC.swift
//  RemindMe
//
//  Created by Raghu, Reshma L on 9/15/18.
//  Copyright © 2018 Raghu, Reshma L. All rights reserved.
//

import UIKit
import Spring

class FirstVC: UIViewController {

	@IBOutlet var button: SpringButton!
	@IBOutlet var image: SpringImageView!

	override func viewDidAppear(_ animated: Bool) {
		image.animation = "morph"
		image.curve = "easeInCirc"
		image.duration = 2.0
		image.animate()

		button.animation = "pop"
		button.curve = "easeIn"
		button.duration = 2.0
		button.repeatCount = 20
		button.delay = 1.0
		button.animate()
	}

	override func viewWillDisappear(_ animated: Bool) {
		// TODO: Need to stop animation
	}
}
