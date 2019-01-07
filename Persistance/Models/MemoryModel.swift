//
//  MemoryModel.swift
//  RemindMe
//
//  Created by Raghu, Reshma L on 1/3/19.
//  Copyright © 2019 Raghu, Reshma L. All rights reserved.
//

import Foundation

struct MemoryModel {
	var uniqueId: Int64!
	var memory: NSString

	init(memory: NSString) {
		self.memory = memory
	}
}

struct Link {
	var word: NSString
	var memoryId: Int64

	init(word: NSString, memoryId: Int64) {
		self.word = word
		self.memoryId = memoryId
	}
}

extension MemoryModel: SQLTable {

	static var createStatement: String {
		return """
		CREATE TABLE Memories(
		Id INTEGER PRIMARY KEY AUTOINCREMENT,
		Memory VARCHAR(1024) NOT NULL
		);
		"""
	}
}

extension Link: SQLTable {

	static var createStatement: String {
		return """
		CREATE TABLE Links(
		Word VARCHAR(256) NOT NULL,
		MemoryId INTEGER NOT NULL,
		PRIMARY KEY (Word, MemoryId)
		);
		"""
	}
}
