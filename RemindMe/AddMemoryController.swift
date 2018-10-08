//
//  AddMemoryController.swift
//  RemindMe
//
//  Created by Raghu, Reshma L on 9/15/18.
//  Copyright © 2018 Raghu, Reshma L. All rights reserved.
//

import UIKit

class AddMemoryController: UIViewController, UITextFieldDelegate {

	@IBOutlet var inputTextField: UITextField!

	override func viewDidLoad() {
		inputTextField.useUnderline()
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		inputTextField.resignFirstResponder()
		return true
	}
}
