//
//  AboutViewController.swift
//  Planable
//
//  Created by Terry Zhuang on 5/14/21.
//

import UIKit
import Firebase

class AboutViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var post: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if post == nil {
            post = Post()
        }
        nameLabel.text = Auth.auth().currentUser?.displayName
    }

    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
    }
    

}
