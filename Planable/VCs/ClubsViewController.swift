//
//  ClubsViewController.swift
//  Planable
//
//  Created by Terry Zhuang on 5/14/21.
//

import UIKit

class ClubsViewController: UIViewController {

    @IBOutlet weak var clubTableView: UITableView!
    
    var searchText = ""
    var clubs = ["4Boston", "Accounting Academy", "Acoustics", "African Student Organization", "Against The Current Acapella", "AHANA Graduate Student Association", "AHANA Management Academy", "AHANA Pre-Law Student Association", "AIDS Awareness Committee", "Al Noor: The Boston College Middle East and Islamic Journal", "Allies", "Alpha Sigma Nu", "Ambassadors", "American Chemical Society", "American Red Cross", "Americans for Informed Democracy", "Amnesty International", "Animal Advocates", "Anime of Boston College", "Appalachia Volunteers", "Arab Students Association", "Army ROTC", "Arrupe International Immersion"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clubTableView.delegate = self
        clubTableView.dataSource = self
        
    }
    

    

}
extension ClubsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = clubTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = clubs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
