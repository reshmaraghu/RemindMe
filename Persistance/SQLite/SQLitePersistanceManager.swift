//
//  SQLitePersistanceManager.swift
//  RemindMe
//
//  Created by Raghu, Reshma L on 1/2/19.
//  Copyright © 2019 Raghu, Reshma L. All rights reserved.
//

import Foundation
import RAMReel

struct SQLitePersistanceManager {

	private let folderPath = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first!
	private let dbName = "MemoryBank.sqlite"
	private var db: SQLiteDatabase? = nil
	static let sharedManager = SQLitePersistanceManager()

	private init() {
		do {
			db = try SQLiteDatabase.open(path: getDBPath())
			if !isDBInitialized() {
				initializeDatabase()
			}
		} catch {
			print("❌ Unable to open database")
		}
	}

	private func getDBPath() -> String {
		let fileManager = FileManager.default
		if !fileManager.fileExists(atPath: folderPath) {
			do {
				try fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: false, attributes: nil)
			} catch let error as NSError {
				print(error.localizedDescription);
			}
		}
		return folderPath + "/" + dbName
	}

	private func initializeDatabase() {
		// Create the tables
		do {
			try db?.createTable(table: MemoryModel.self)
			try db?.createTable(table: Link.self)
			UserDefaults.standard.set(true, forKey: "isDBInitialized")
		} catch {
			print("❌ Unable to innitialize database")
		}
	}

	private func isDBInitialized() -> Bool {
		return UserDefaults.standard.bool(forKey: "isDBInitialized")
	}
}

extension SQLitePersistanceManager: Persistance, FlowDataSource {

	func save(text: String, for words: [String]) {
		do {
			if let memoryId = try db?.insertMemory(memory: MemoryModel(memory: text as NSString)) {
				for word in words {
					do {
						try db?.insertLink(link: Link(word: word as NSString, memoryId: memoryId))
					} catch let error as NSError {
						print("❌ Unable to save word \(word): \(error.localizedDescription)")
					}
				}
			}
		} catch let error as NSError {
			print("❌ Unable to save memory \(text): \(error.localizedDescription)")
		}
	}

	typealias CompletionHandler = (_ memories: [String]) -> Void
	func getMemories(for word: String, completionHandler: @escaping CompletionHandler) {
		var memories = [String]()
		do {
			if let links = try db?.getLinks(word: word as NSString) {
				for link in links {
					do {
						if let memory = try db?.getMemory(id: link.memoryId) {
							memories.append(memory.memory as String)
						}
					} catch let error as NSError {
						print("❌ Unable to get memory for \(link.memoryId):\(link.word) : \(error.localizedDescription)")
					}
				}
			}

		} catch let error as NSError {
			print("❌ Unable to get links for \(word): \(error.localizedDescription)")
		}
		completionHandler(memories)
	}

	public func resultsForQuery(_ query: String, completionHandler: @escaping (_ memories: [String]) -> Void) {
		if(query == ""){
			completionHandler([""])
		} else{
			self.getMemories(for: query) {(memories) in
				completionHandler(memories)
			}
		}
	}
}
