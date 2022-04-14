//
//  MainTableViewController.swift
//  Forabet Challenge
//
//  Created by BSergio on 30.03.2022.
//

import UIKit

protocol MainDelegate {
    func newGame()
    func setParametrs(paramers: String)
}

class MainTableViewController: UITableViewController {
    
    // MARK: - Private Properties
    private var completedGame: [GameModel] = []
    private var notCompletedGame: [GameModel] = []
    private var afmanager: AppsflyerManager!
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        registrationCell()
        afmanager = AppsflyerManager(delegate: self)
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
        section == 0 ? "Active" : "Completed"
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("tut go add prepare before optional \(segue.destination)")
        guard let nc = segue.destination as? UINavigationController else { return }
        
        guard let vc = nc.topViewController as? AddGameCollectionViewController else { return }
        vc.delegate = self
    }
}

// MARK: - Private Methodes
extension MainTableViewController {
    private func fetchDb() {
        StorageManager.shared.fetchGame { [weak self] results in
            self?.completedGame = results.filter { $0.currentStatusGame == 0 }
            self?.notCompletedGame = results.filter { $0.currentStatusGame == 1 || $0.currentStatusGame == 2 }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func registrationCell() {
        let cellMainActiveGameTableViewCell = UINib(nibName: "MainActiveGameTableViewCell", bundle: nil)
        tableView.register(cellMainActiveGameTableViewCell, forCellReuseIdentifier: "mainActiveGameTableViewCell")
        tableView.separatorStyle = .none
    }
}
// MARK: - Main delegate
extension MainTableViewController: MainDelegate {
   
    func newGame() {
        fetchDb()
        tableView.reloadData()
    }
    
    func setParametrs(paramers: String) {
        fetchRemoteConfig(for: paramers)
    }
}

// MARK: - Fetch remote congig
extension MainTableViewController {
    private func fetchRemoteConfig(for parametrs: String) {
        
        RemoteConfigManager.shared.fetchRemoteConfig(for: parametrs) { [ weak self ] networManager in
            guard let networManager = networManager else { return }
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: WvViewController.id)  as! WvViewController
                vc.workTarget = networManager
                vc.statusWork = .done
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: false, completion: nil)
            }
        }
    }
}
