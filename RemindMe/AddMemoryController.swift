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
	let pm = PersistanceFactory.getPersistanceManager(type: DBTYPE.sqlite)

	override func viewDidLoad() {
		inputTextField.useUnderline()
		inputTextField.becomeFirstResponder()
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		inputTextField.resignFirstResponder()
		print("♻️♻️♻️♻️♻️♻️♻️♻️")
		print("♻️ \(textField.text ?? "no text")")
		var words: [String] = []

		let tagger = NSLinguisticTagger(tagSchemes: [.lexicalClass], options: 0)
		tagger.string = textField.text
		let range = NSRange(location: 0, length: textField.text?.count ?? 0)
		let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]
		tagger.enumerateTags(in: range, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange, _ in
			if let tag = tag {
				if tag == .noun {
					let word = (textField.text! as NSString).substring(with: tokenRange)
					print("♻️ \(word) : \(tag)")
					words.append(word)
				}
			}
		}
		print("♻️♻️♻️♻️♻️♻️♻️♻️")
		if let memory = textField.text, memory != "" {
			pm.save(text: memory, for: words)
		}
		return true
	}
}
