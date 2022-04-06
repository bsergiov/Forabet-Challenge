//
//  MainTableViewController.swift
//  Forabet Challenge
//
//  Created by BSergio on 30.03.2022.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    // MARK: - Public Properties
    var isTimerShow = false
    
    // MARK: - Private Properties
    private var completedGame: [GameModel] = []
    private var notCompletedGame: [GameModel] = []
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellMainActiveGameTableViewCell = UINib(nibName: "MainActiveGameTableViewCell", bundle: nil)
        tableView.register(cellMainActiveGameTableViewCell, forCellReuseIdentifier: "mainActiveGameTableViewCell")
        tableView.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchDb()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? completedGame.count : notCompletedGame.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainActiveGameTableViewCell", for: indexPath) as! MainActiveGameTableViewCell
        cell.game = indexPath.section == 0 ? completedGame[indexPath.row] : notCompletedGame[indexPath.row]
        cell.setupCellActiveGame()
        return cell
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GameCollectionViewController") as! GameCollectionViewController
        
        vc.game = indexPath.section == 0 ? completedGame[indexPath.row] : notCompletedGame[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
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
