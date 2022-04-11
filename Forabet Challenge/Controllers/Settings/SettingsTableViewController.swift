//
//  SettingsTableViewController.swift
//  Forabet Challenge
//
//  Created by SV on 11.04.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    // MARK: - IB Action
    @IBAction func policyAndTermsTapped(_ sender: UIButton) {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: WvViewController.id) as! WvViewController
        vc.workUrl = sender.tag == 0 ? .policy : .terms
        present(vc, animated: true)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : 2
    }
}

