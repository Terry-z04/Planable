//
//  AddCommunityPostViewController.swift
//  Planable
//
//  Created by Terry Zhuang on 5/16/21.
//

import UIKit
import Firebase

class AddCommunityPostViewController: UIViewController {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTextField: UITextView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    
    var post: Post!
    var imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide keyboard if we tap outside of a field
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        imagePickerController.delegate = self
        
        if post == nil {
            post = Post()
        }
        
        updateUserInterface()
        
    }
    
    
    func updateUserInterface() {
        postTextField.text = post.postText
        postImageView.image = post.postImage
        
    }
    
    func updateFromInterface() {
        post.postText = postTextField.text!
        post.postImage = postImageView.image!
    }
    
    func leaveViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    func cameraOrLibraryAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            print("You clicked Photo Library")
            self.accessPhotoLibrary()
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
            print("You clicked Camera")
            self.accessCamera()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        updateFromInterface()
        post.saveData(post: post) { (success) in
            if success {
                self.leaveViewController()
            } else {
                self.oneButtonAlert(title: "Post Failed", message: "For some reason, the data would not save to the cloud.")
            }
        }
        
    }
    
    @IBAction func photoButtonPressed(_ sender: UIButton) {
        cameraOrLibraryAlert()
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        leaveViewController()
    }
    

}

extension AddCommunityPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        post = Post()
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            post.postImage = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            post.postImage = originalImage
            postImageView.image = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func accessPhotoLibrary() {
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    func accessCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            present(imagePickerController, animated: true, completion: nil)
        } else {
            self.oneButtonAlert(title: "Camera Not Available", message: "There is no camera available on this device.")
        }
    }
}
