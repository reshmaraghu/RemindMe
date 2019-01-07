//
//  SQLiteDatabase.swift
//  RemindMe
//
//  Created by Raghu, Reshma L on 1/3/19.
//  Copyright © 2019 Raghu, Reshma L. All rights reserved.
//

import Foundation
import SQLite3

class SQLiteDatabase {

	fileprivate let dbPointer: OpaquePointer?

	fileprivate init(dbPointer: OpaquePointer?) {
		self.dbPointer = dbPointer
	}

	deinit {
		sqlite3_close(dbPointer)
	}

	static func open(path: String) throws -> SQLiteDatabase {
		var db: OpaquePointer? = nil
		if sqlite3_open(path, &db) == SQLITE_OK {
			return SQLiteDatabase(dbPointer: db)
		} else {
			defer {
				if db != nil {
					sqlite3_close(db)
				}
			}
			if let errorPointer = sqlite3_errmsg(db) {
				let message = String.init(cString: errorPointer)
				throw SQLiteError.OpenDatabase(message: message)
			} else {
				throw SQLiteError.OpenDatabase(message: "No error message provided from sqlite.")
			}
		}
	}

	func prepareStatement(sql: String) throws -> OpaquePointer? {
		var statement: OpaquePointer? = nil
		guard sqlite3_prepare_v2(dbPointer, sql, -1, &statement, nil) == SQLITE_OK else {
			throw SQLiteError.Prepare(message: errorMessage)
		}
		return statement
	}

	fileprivate var errorMessage: String {
		if let errorPointer = sqlite3_errmsg(dbPointer) {
			let errorMessage = String(cString: errorPointer)
			return errorMessage
		} else {
			return "No error message provided from sqlite."
		}
	}

	func createTable(table: SQLTable.Type) throws {
		let createTableStatement = try prepareStatement(sql: table.createStatement)
		defer {
			sqlite3_finalize(createTableStatement)
		}
		guard sqlite3_step(createTableStatement) == SQLITE_DONE else {
			throw SQLiteError.Step(message: errorMessage)
		}
		print("✴️✴️\(table) table created.")
	}

	func insertMemory(memory: MemoryModel) throws -> Int64 {
		let insertSql = "INSERT INTO Memories (Memory) VALUES (?);"
		let insertStatement = try prepareStatement(sql: insertSql)
		let memory: NSString = memory.memory
		guard sqlite3_bind_text(insertStatement, 1, memory.utf8String, -1, nil) == SQLITE_OK else {
			throw SQLiteError.Bind(message: errorMessage)
		}
		guard sqlite3_step(insertStatement) == SQLITE_DONE else {
			throw SQLiteError.Step(message: errorMessage)
		}
		let rowId = sqlite3_last_insert_rowid(self.dbPointer)
		print("✴️✴️Successfully inserted row: \(rowId) - \(memory)")
		sqlite3_finalize(insertStatement)
		return rowId
	}

	func insertLink(link: Link) throws {
		let insertSql = "INSERT INTO Links (Word, MemoryId) VALUES (?, ?);"
		let insertStatement = try prepareStatement(sql: insertSql)
		let word: NSString = link.word
		let memoryId: Int64 = link.memoryId
		guard sqlite3_bind_text(insertStatement, 1, word.utf8String, -1, nil) == SQLITE_OK &&
				sqlite3_bind_int64(insertStatement, 2, memoryId) == SQLITE_OK else {
			throw SQLiteError.Bind(message: errorMessage)
		}
		guard sqlite3_step(insertStatement) == SQLITE_DONE else {
			throw SQLiteError.Step(message: errorMessage)
		}
		print("✴️✴️Successfully inserted row: \(word)-\(memoryId)")
		sqlite3_finalize(insertStatement)
	}

	func getMemory(id: Int64) throws -> MemoryModel {
		let queryStatementString = "SELECT * FROM Memories WHERE Id = ?;"
		guard let queryStatement = try? prepareStatement(sql: queryStatementString) else {
			throw SQLiteError.Prepare(message: errorMessage)
		}
		defer {
			sqlite3_finalize(queryStatement)
		}
		guard sqlite3_bind_int64(queryStatement, 1, id) == SQLITE_OK else {
			throw SQLiteError.Bind(message: errorMessage)
		}
		let uniqueId = sqlite3_column_int64(queryStatement, 0)
		let memory = String(cString: sqlite3_column_text(queryStatement, 1)!) as NSString
		var memoryModel = MemoryModel(memory: memory)
		memoryModel.uniqueId = uniqueId
		print("✴️✴️Successfully fetched row: \(uniqueId)-\(memory)")
		return memoryModel
	}

	func getLinks(word: NSString) throws -> [Link] {
		var links = [Link]()
		let queryStatementString = "SELECT * FROM Links WHERE Word = ?;"
		guard let queryStatement = try? prepareStatement(sql: queryStatementString) else {
			throw SQLiteError.Prepare(message: errorMessage)
		}
		defer {
			sqlite3_finalize(queryStatement)
		}
		guard sqlite3_bind_text(queryStatement, 1, word.utf8String, -1, nil) == SQLITE_OK else {
			throw SQLiteError.Bind(message: errorMessage)
		}
		while(sqlite3_step(queryStatement) == SQLITE_ROW) {
			let word = String(cString: sqlite3_column_text(queryStatement, 0)!) as NSString
			let memoryId = sqlite3_column_int64(queryStatement, 1)
			let link = Link(word: word, memoryId: memoryId)
			links.append(link)
			print("✴️✴️Successfully fetched row: \(memoryId)-\(word)")
		}
		return links
	}

}


enum SQLiteError: Error {
	case OpenDatabase(message: String)
	case Prepare(message: String)
	case Step(message: String)
	case Bind(message: String)
}
