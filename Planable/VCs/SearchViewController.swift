//
//  SearchViewController.swift
//  Planable
//
//  Created by Terry Zhuang on 5/16/21.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchPageImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide keyboard if we tap outside of a field
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        searchTextField.alpha = 0.0
        searchButton.alpha = 0.0
        searchPageImageView.alpha = 0.0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        UIView.animate(withDuration: 3.0, animations: {
            self.searchPageImageView.alpha = 1.0
            self.searchTextField.alpha = 1.0
            self.searchButton.alpha = 1.0
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowClubs" {
            var searchText = searchTextField.text!
            searchText = searchText.replacingOccurrences(of: " ", with: "")
            let destination = segue.destination as! ClubsViewController
            destination.searchText = searchText
        }
    }
    
    

}
