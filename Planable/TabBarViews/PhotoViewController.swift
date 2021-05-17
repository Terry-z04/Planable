//
//  PhotoViewController.swift
//  Planable
//
//  Created by Terry Zhuang on 5/17/21.
//

import UIKit
import SDWebImage

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    var post: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if post == nil {
            post = Post()
        }
        updateUserInterface()
    }
    
    
    
    func updateUserInterface() {
        guard let url = URL(string: post.photoURL) else {
            detailImageView.image = post.postImage
            return
        }
        detailImageView.sd_imageTransition = .fade
        detailImageView.sd_imageTransition?.duration = 0.5
        detailImageView.sd_setImage(with: url)
        
    }
    

}
