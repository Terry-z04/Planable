//
//  RSVPsViewController.swift
//  Planable
//
//  Created by Terry Zhuang on 5/14/21.
//

import UIKit

class RSVPsViewController: UIViewController {
    
    @IBOutlet weak var rsvpsTableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    var eventRSVP = ["Basic Finance Exam", "Alumni Job Shadow"]
    var timeString = ["05/17/21 12:30:00 PM", "05/21/21 09:00:00 AM"]

    override func viewDidLoad() {
        super.viewDidLoad()
        rsvpsTableView.delegate = self
        rsvpsTableView.dataSource = self
        
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if rsvpsTableView.isEditing {
            rsvpsTableView.setEditing(false, animated: true)
            sender.title = "Edit"
            addBarButton.isEnabled = true
        } else {
            rsvpsTableView.setEditing(true, animated: true)
            sender.title = "Done"
            addBarButton.isEnabled = false
        }
    }

}
extension RSVPsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventRSVP.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rsvpsTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = eventRSVP[indexPath.row]
        cell.detailTextLabel?.text = timeString[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            eventRSVP.remove(at: indexPath.row)
            rsvpsTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = eventRSVP[sourceIndexPath.row]
        eventRSVP.remove(at: sourceIndexPath.row)
        eventRSVP.insert(itemToMove, at: sourceIndexPath.row)
    }
    
}
