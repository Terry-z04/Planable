//
//  Post.swift
//  Planable
//
//  Created by Terry Zhuang on 5/16/21.
//

import Foundation
import Firebase

class Post: NSObject {
    var postText: String
    var postingUserID: String
    var numberOfPosts: Int
    var postImage: UIImage
    var photoURL: String
    var name: String
    var documentID: String
    
    var dictionary: [String: Any] {
        return ["postText" : postText, "postingUserID" : postingUserID, "numberOfPosts" : numberOfPosts, "photoURL" : photoURL, "name" : name]
    }
    
    
    init(postText: String, postingUserID: String, numberOfPosts: Int, postImage: UIImage, photoURL: String, name: String, documentID: String) {
        self.postText = postText
        self.postingUserID = postingUserID
        self.numberOfPosts = numberOfPosts
        self.postImage = postImage
        self.photoURL = photoURL
        self.name = name
        self.documentID = documentID
    }
    
    convenience override init() {
        let name = Auth.auth().currentUser?.displayName ?? ""
        
        self.init(postText: "Please Enter Your Text Here.", postingUserID: "", numberOfPosts: 0, postImage: UIImage(), photoURL: "", name: name, documentID: "")
    }
    
    
    convenience init(dictionary: [String: Any]) {
        let postText = dictionary["postText"] as! String? ?? ""
        let numberOfPosts = dictionary["numberOfPosts"] as! Int? ?? 0
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
        let photoURL = dictionary["photoURL"] as! String? ?? ""
        let name = dictionary["name"] as! String? ?? ""
        
        self.init(postText: postText, postingUserID: postingUserID, numberOfPosts: numberOfPosts, postImage: UIImage(),  photoURL: photoURL, name: name, documentID: "")
    }
    
    func saveIfNewUser(completion: @escaping (Bool)->()) {
        let db = Firestore.firestore()
        let userRef = db.collection("posts").document(documentID)
        userRef.getDocument { document, error in
            guard error == nil else {
                print("😡 ERROR: Could not access document for user \(self.documentID)")
                return completion(false)
            }
            
            guard document?.exists == false else {
                print("👍🏻 The document for user \(self.documentID) already exists. No reason to re-create it.")
                return completion(true)
            }
            
            // create the new document
            let dataToSave: [String: Any] = self.dictionary
            db.collection("posts").document(self.documentID).setData(dataToSave) { error in
                guard error == nil else{
                    print("😡 ERROR: \(error?.localizedDescription), could not save data for \(self.documentID)")
                    return completion(false)
                }
                return completion(true)
            }
        }
    }
    
    func saveText(completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        
        // Grab the user ID
        guard let postingUserID = Auth.auth().currentUser?.uid else {
            print("ERROR: Could not save data because we don't have a valid postingUserID.")
            return completion(false) // indicating we did not safely save data
        }
        self.postingUserID = postingUserID
        // Create the dictionary representing data we want to save
        let dataToSave: [String: Any] = self.dictionary
        // if we HAVE saved a record, we'll have an ID, otherwise .addDocument will create one.
        if self.documentID == "" { // Create a new document via . addDocument
            var ref: DocumentReference? = nil // Firestore will create a new ID for us
            ref = db.collection("posts").addDocument(data: dataToSave){ (error) in
                guard error == nil else {
                    print("😡 ERROR: adding document \(error!.localizedDescription)")
                    return completion(false)
                }
                self.documentID = ref!.documentID
                print("😆 Added document: \(self.documentID)") // It worked!
                completion(true)
            }
        } else { // else save to the existing documenID w/ .setData
            let ref = db.collection("posts").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                guard error == nil else {
                    print("😡 ERROR: updating document \(error!.localizedDescription)")
                    return completion(false)
                }
                print("😆 Updated document: \(self.documentID)") // It worked!
                completion(true)
            }
        }
    }
    
    func saveData(post: Post, completion: @escaping (Bool) -> ()) {
    
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
        let storageRef = storage.reference().child(post.documentID)
        
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
                self.saveText { (success) in
                    if success {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
                self.saveIfNewUser { (success) in
                    if success {
                        completion(true)
                    } else {
                        completion(false)
                    }
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
        let storageRef = storage.reference().child(post.documentID)
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
