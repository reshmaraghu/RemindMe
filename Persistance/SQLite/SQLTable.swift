//
//  SQLTable.swift
//  RemindMe
//
//  Created by Raghu, Reshma L on 1/3/19.
//  Copyright © 2019 Raghu, Reshma L. All rights reserved.
//

import Foundation

protocol SQLTable {
	static var createStatement: String { get }
}
