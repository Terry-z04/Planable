//
//  Posts.swift
//  Planable
//
//  Created by Terry Zhuang on 5/16/21.
//

import Foundation
import Firebase

class Posts {
    
    var postArray: [Post] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping() -> ()) {
        
        db.collection("posts").addSnapshotListener { (querySnapshiot, error) in
            guard error == nil else {
                print("ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.postArray = [] // Clean out existing spotArray since new data will load
            // there are querySnapshot!.documents.count documents in the snapshot
            for document in querySnapshiot!.documents {
                let post = Post(dictionary: document.data())
                post.documentID = document.documentID
                self.postArray.append(post)
            }
            completed()
        }
    }
    
}
