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

	override func viewDidAppear(_ animated: Bool) {
		button.animation = "pop"
		button.curve = "easeIn"
		button.duration = 2.0
		button.repeatCount = 20
		button.animate()
	}

	override func viewWillDisappear(_ animated: Bool) {
		// TODO: Need to stop animation
	}
}
