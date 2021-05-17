//
//  Users.swift
//  Planable
//
//  Created by Terry Zhuang on 5/16/21.
//

import Foundation
import Firebase

class Users {
    var userArray: [User] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping() -> ()) {
        db.collection("users").addSnapshotListener { (querySnapshiot, error) in
            guard error == nil else {
                print("ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.userArray = [] // Clean out existing userArray since new data will load
            // there are querySnapshot!.documents.count documents in the snapshot
            for document in querySnapshiot!.documents {
                let user = User(dictionary: document.data())
                user.documentID = document.documentID
                self.userArray.append(user)
            }
            completed()
        }
    }
}
