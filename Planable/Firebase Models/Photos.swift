//
//  Photos.swift
//  Planable
//
//  Created by Terry Zhuang on 5/16/21.
//

import Foundation
import Firebase

class Photos {
    var photoArray: [Photo] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        
        db.collection("posts").document(post.documentID).collection("photos").addSnapshotListener { (querySnapshiot, error) in
            guard error == nil else {
                print("ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.photoArray = [] // Clean out existing photoArray since new data will load
            // there are querySnapshot!.documents.count documents in the snapshot
            for document in querySnapshiot!.documents {
                // you'll have to make sure you have a dictionary initializer in the singular class.
                let photo = Photo(dictionary: document.data())
                photo.documentID = document.documentID
                self.photoArray.append(photo)
            }
            completed()
        }
    }
    
}
