//
//  PersistanceFactory.swift
//  RemindMe
//
//  Created by Raghu, Reshma L on 4/4/18.
//  Copyright © 2018 Raghu, Reshma L. All rights reserved.
//

import Foundation

enum DBTYPE {
	case firebase
	case sqlite
}

struct PersistanceFactory {

	static func getPersistanceManager(type: DBTYPE) -> Persistance {

		switch type {
		case .firebase:
			return FirebasePersistanceManager()
		case .sqlite:
			return SQLitePersistanceManager.sharedManager
		}
	}
}
