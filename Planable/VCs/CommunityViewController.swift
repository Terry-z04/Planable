//
//  CommunityViewController.swift
//  Planable
//
//  Created by Terry Zhuang on 5/14/21.
//

import UIKit
import Firebase

class CommunityViewController: UIViewController {
    
    @IBOutlet weak var postTableView: UITableView!
    
    var posts: Posts!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posts = Posts()
        
        postTableView.delegate = self
        postTableView.dataSource = self
        
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        posts.loadData {
            DispatchQueue.main.async {
                self.postTableView.reloadData()
            }
        }
    }
    

}
extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CommunityPostTableViewCell
        cell.post = posts.postArray[indexPath.row]
        cell.postTextView.text = posts.postArray[indexPath.row].postText
        cell.nameLabel.text = posts.postArray[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}
