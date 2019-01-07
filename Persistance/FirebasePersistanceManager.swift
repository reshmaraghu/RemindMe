//
//  FirebasePersistanceManager.swift
//  RemindMe
//
//  Created by Raghu, Reshma L on 4/4/18.
//  Copyright © 2018 Raghu, Reshma L. All rights reserved.
//

import Foundation
import Firebase
import RAMReel

struct FirebasePersistanceManager {

	private var db: Firestore

	init() {
		if(FirebaseApp.app() == nil){
			FirebaseApp.configure()
		}
		db = Firestore.firestore()
		let settings = db.settings
		settings.areTimestampsInSnapshotsEnabled = true
		db.settings = settings
	}
}

extension FirebasePersistanceManager: Persistance {

	func save(text: String, for words: [String]) {

		// Save the memory
		db.collection("sup").document("memory").collection(text).addDocument(data: ["" : ""])
		//db.collection("sup").document("memory").
		// Save the mapping

		//var ref: DocumentReference? = nil
		/*var collRef: CollectionReference
		for word in words {
			//db.collection("Supreeth").document(word).setData([word : text], merge: true)
			collRef = db.collection("Supreeth").document(word).collection(text)
			collRef.addDocument(data: ["":""])
		}*/

		/*ref = db.collection("Supreeth").addDocument(data: ["memory" : text]) { err in
			if let err = err {
				print("Error adding document: \(err)")
			} else {
				print("Document added with ID: \(ref!.documentID)")
			}
		}*/
	}

	typealias CompletionHandler = (_ memories: [String]) -> Void
	func getMemories(for word: String, completionHandler: @escaping CompletionHandler) {
		var memories = [""]
		db.collection("Reshma").document("keyWords").getDocument(completion: { (documentSnapshot, error) in
			if let document = documentSnapshot, document.exists {
				//print("♻️ \(document.data())")
				if let arrayOfDocumentIDs = document.data()?[word] as? [String] {
					for (index, documentID) in arrayOfDocumentIDs.enumerated() {
						//print("♻️♻️ \(documentID)")
						self.db.collection("Reshma").document(documentID).getDocument(completion: { (documentOfMemorySnapshot, error) in
							if let documentOfMemory = documentOfMemorySnapshot, documentOfMemory.exists {
								if let memory = documentOfMemory.data()?["memory"] as? String {
									memories.append(memory)
									print("♻️♻️♻️ \(memory)")
									if index == (arrayOfDocumentIDs.count-1) {
										completionHandler(memories)
									}
								}
							}
						})
					}
				} else {
					completionHandler(memories)
				}
			}
		})
	}
}

extension FirebasePersistanceManager: FlowDataSource {

	/// Returns all the strings that starts with query string
	/*public func resultsForQuery(_ query: String) -> [String] {
		if(query == ""){
			return [] // self.data.words
		}else{
			self.getMemories(for: query) {(memories) in
				return memories
			}
			return []
		}
	}*/

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
