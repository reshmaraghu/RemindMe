//
//  MemoryBankManager.swift
//  RemindMe
//
//  Created by Raghu, Reshma L on 4/4/18.
//  Copyright © 2018 Raghu, Reshma L. All rights reserved.
//

import Foundation

struct MemoryBankManager {
	static let shared = MemoryBankManager()
	let db: Persistance = PersistanceFactory.getPersistanceManager()
	
	private init() {

	}

	public func recollectMemories(for subject: String) -> [Memory] {
		return [Memory]()
	}
}
