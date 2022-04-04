//
//  MainTableViewController.swift
//  Forabet Challenge
//
//  Created by BSergio on 30.03.2022.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var isTimerShow = false
    
    private var completedGame: [GameModel] = []
    private var notCompletedGame: [GameModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDb()
        
        let cellMainActiveGameTableViewCell = UINib(nibName: "MainActiveGameTableViewCell", bundle: nil)
        tableView.register(cellMainActiveGameTableViewCell, forCellReuseIdentifier: "mainActiveGameTableViewCell")
        tableView.separatorStyle = .none
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? completedGame.count : notCompletedGame.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainActiveGameTableViewCell", for: indexPath) as! MainActiveGameTableViewCell
        
        switch indexPath.section {
        case 0:
            return cell
        default:
            cell.setupCellNonActiveGame()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Active"
        case 1:
            return "None Active"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        95
    }
}

// MARK: - Private Methodes
extension MainTableViewController {
    private func fetchDb() {
        StorageManager.shared.fetchGame { [weak self] results in
            self?.completedGame = results.filter { !$0.isComleted }
            self?.notCompletedGame = results.filter { $0.isComleted }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
