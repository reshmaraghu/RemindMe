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
}

struct PersistanceFactory {

	private static let dbType = DBTYPE.firebase

	static func getPersistanceManager() -> Persistance {

		switch dbType {
		case .firebase:
			return FirebasePersistanceManager()
		}
	}
}
