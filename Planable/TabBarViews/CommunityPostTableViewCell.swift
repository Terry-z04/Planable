//
//  CommunityPostTableViewCell.swift
//  Planable
//
//  Created by Terry Zhuang on 5/14/21.
//

import UIKit

class CommunityPostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var postImageView: UIImageView!
    
    var post: Post! {
        didSet {
            post.loadImage(post: post) { (success) in
                if success {
                    self.postImageView.image = self.post.postImage
                } else {
                    print("ERROR: no success in loading photo in CommunityPostTableViewCell")
                }
            }
        }
    }
    
}
