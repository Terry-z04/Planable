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
    
    var rspvs = RSPVs()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rsvpsTableView.delegate = self
        rsvpsTableView.dataSource = self
        
        rspvs.loadData {
            self.rsvpsTableView.reloadData()
        }
        
    }
    
    func saveData() {
        rspvs.saveData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEvent" {
            let destination = segue.destination as! AddRSPVsViewController
            let selectedIndexPath = rsvpsTableView.indexPathForSelectedRow!
            destination.rsvp = rspvs.rspvArray[selectedIndexPath.row]
        } else {
            if let selectedIndexPath = rsvpsTableView.indexPathForSelectedRow {
                rsvpsTableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        let source = segue.source as! AddRSPVsViewController
        if let selectedIndexPath = rsvpsTableView.indexPathForSelectedRow {
            rspvs.rspvArray[selectedIndexPath.row] = source.rsvp
            rsvpsTableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: rspvs.rspvArray.count, section: 0)
            rspvs.rspvArray.append(source.rsvp)
            rsvpsTableView.insertRows(at: [newIndexPath], with: .bottom)
            rsvpsTableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
        saveData()
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
        return rspvs.rspvArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rsvpsTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = rspvs.rspvArray[indexPath.row].name
        cell.detailTextLabel?.text = "\(rspvs.rspvArray[indexPath.row].date)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            rspvs.rspvArray.remove(at: indexPath.row)
            rsvpsTableView.deleteRows(at: [indexPath], with: .fade)
            saveData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = rspvs.rspvArray[sourceIndexPath.row]
        rspvs.rspvArray.remove(at: sourceIndexPath.row)
        rspvs.rspvArray.insert(itemToMove, at: sourceIndexPath.row)
        saveData()
    }
    
}
