//
//  CommunityViewController.swift
//  Planable
//
//  Created by Terry Zhuang on 5/14/21.
//

import UIKit

class CommunityViewController: UIViewController {
    
    @IBOutlet weak var postTableView: UITableView!
    
    var idArray = ["Boston College"]
    var postText = "Good luck to these Eagles as they host the NCAA Tournament this weekend!! Photo: Kristian Lamarre '24"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTableView.delegate = self
        postTableView.dataSource = self
        
    }
    
    
    

}
extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CommunityPostTableViewCell
        cell.nameLabel.text = idArray[indexPath.row]
        cell.profileImageView.image = UIImage(named: "1200px-Boston_College_Eagles_logo.svg")
        cell.postTextView.text = postText
        cell.postImageView.image = UIImage(named: "IMG_EA142A9DE4DD-1")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
}
