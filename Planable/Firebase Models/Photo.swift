//
//  Photo.swift
//  Planable
//
//  Created by Terry Zhuang on 5/16/21.
//

import UIKit
import Firebase

class Photo: NSObject {
    var postImage: UIImage
    var photoUserID: String
    var photoURL: String
    var documentID: String
    
    var dictionary: [String: Any] {
        return["photoUserID": photoUserID, "photoURL": photoURL]
    }
    
    init(postImage: UIImage, photoUserID: String, photoURL: String, documentID: String) {
        self.postImage = postImage
        self.photoUserID = photoUserID
        self.photoURL = photoURL
        self.documentID = documentID
    }
    
    override
    convenience init() {
        let photoUserID = Auth.auth().currentUser?.uid ?? ""
        self.init(postImage: UIImage(), photoUserID: photoUserID, photoURL: "", documentID: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        
        let photoUserID = dictionary["photoUserID"] as! String? ?? ""
        let photoURL = dictionary["photoURL"] as! String? ?? ""
        
        self.init(postImage: UIImage(), photoUserID: photoUserID, photoURL: photoURL, documentID: "")
    }
    
    func saveData(post: Post, completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        let storage = Storage.storage()
        
        // convert photo.image to a Data type so that it can be saved in Firebase Storage
        guard let photoData = self.postImage.jpegData(compressionQuality: 0.5) else {
            print("😡 ERROR: Could not convert photo.image to Data.")
            return
        }
        
        // create metadata so that we can see images in the Firebase Storage Console
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpeg"
        
        // create filename if necessary
        if documentID == "" {
            documentID = UUID().uuidString
        }
        
        // create a storage reference to upload this image file to the spot's folder
        let storageRef = storage.reference().child(post.documentID).child(documentID)
        
        // create an uploadTask
        let uploadTask = storageRef.putData(photoData, metadata: uploadMetaData) { (metadata, error) in
            if let error = error {
                print("😡 ERROR: upload for ref \(uploadMetaData) failed. \(error.localizedDescription)")
            }
        }
        
        uploadTask.observe(.success) { (snapshot) in
            print("Upload to Firebase Storage was successful!!")
            
            storageRef.downloadURL { (url, error) in
                guard error == nil else {
                    print("😡 ERROR: Couldn;t create a download url \(error!.localizedDescription)")
                    return completion(false)
                }
                
                guard let url = url else {
                    print("😡 ERROR: url was nil and this should not have happened because we've already shown there was no error.")
                    return completion(false)
                }
                self.photoURL = "\(url)"
                
                // Create the dictionary representing data we want to save
                let dataToSave: [String: Any] = self.dictionary
                let ref = db.collection("posts").document(post.documentID).collection("photos").document(self.documentID)
                ref.setData(dataToSave) { (error) in
                    guard error == nil else {
                        print("ERROR: updating document \(error!.localizedDescription)")
                        return completion(false)
                    }
                    print("💨 Added document: \(self.documentID) to post: \(post.documentID)")
                    completion(true)
                }
            }
        }
        
        uploadTask.observe(.failure) { (snapshot) in
            if let error = snapshot.error {
                print("😡 ERROR: upload task for file \(self.documentID) failed, in post \(post.documentID), with error \(error.localizedDescription)")
            }
            completion(false)
        }
    }
    
    func loadImage(post: Post, completion: @escaping (Bool) -> ()) {
        guard post.documentID != "" else {
            print("😡 ERROR: did not pass a valid spot into loadImage")
            return
        }
        let storage = Storage.storage()
        let storageRef = storage.reference().child(post.documentID).child(documentID)
        storageRef.getData(maxSize: 25 * 1024 * 1024) { (data, error) in
            if let error = error {
                print("ERROR: an error occurred while reading data from file ref: \(storageRef) error = \(error.localizedDescription)")
                return completion(false)
            } else {
                self.postImage = UIImage(data: data!) ?? UIImage()
                return completion(true)
            }
        }
    }
    
    
    
}
