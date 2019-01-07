//
//  Persistance.swift
//  RemindMe
//
//  Created by Raghu, Reshma L on 4/4/18.
//  Copyright © 2018 Raghu, Reshma L. All rights reserved.
//

import Foundation

protocol Persistance {

	func save(text: String, for: [String])
}
