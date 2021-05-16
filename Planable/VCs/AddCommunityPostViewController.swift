//
//  AddCommunityPostViewController.swift
//  Planable
//
//  Created by Terry Zhuang on 5/16/21.
//

import UIKit

class AddCommunityPostViewController: UIViewController {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTextField: UITextView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide keyboard if we tap outside of a field
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        
        
    }
    
    
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
        
    }
    
    

}
