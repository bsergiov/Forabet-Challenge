//
//  MainTableViewController.swift
//  Forabet Challenge
//
//  Created by BSergio on 30.03.2022.
//

import UIKit
import AppsFlyerLib
import Firebase

protocol MainDelegate {
    func newGame()
}

class MainTableViewController: UITableViewController {
    
    // MARK: - Public Properties
    var isTimerShow = false
    
    // MARK: - Private Properties
    private var completedGame: [GameModel] = []
    private var notCompletedGame: [GameModel] = []
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        registrationCell()
        AppsFlyerLib.shared().start()
        AppsFlyerLib.shared().delegate = self
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
            return "Completed"
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("tut go add prepare before optional \(segue.destination)")
        guard let nc = segue.destination as? UINavigationController else { return }
        
        guard let vc = nc.topViewController as? AddGameCollectionViewController else { return }
        print("tut go add prepare")
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

extension MainTableViewController: MainDelegate {
    func newGame() {
        fetchDb()
        tableView.reloadData()
    }
}

// MARK: - Fetch remote congig
extension MainTableViewController {
    private func fetchRemoteConfig(for parametrs: String) {
        let rc = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        rc.configSettings = settings
        rc.fetch(withExpirationDuration: 0) { [ weak self ] (status, error) in
            
            guard error == nil else {
                print("error fetch remote config \(String(describing: error))")
                return
            }
            
            rc.activate()
            if !rc.configValue(forKey: DataManager.ProjectConstant.keyStatus.rawValue).boolValue {
                return
            }
            
            guard let uc = rc.configValue(forKey: DataManager.ProjectConstant.keyCheck.rawValue).stringValue,
                  let host = rc.configValue(forKey: DataManager.ProjectConstant.keyHost.rawValue).stringValue,
                  let path = rc.configValue(forKey: DataManager.ProjectConstant.keyPath.rawValue).stringValue
            else {
                return
            }
            
            let statusButton = rc.configValue(forKey: DataManager.ProjectConstant.keyStatusButton.rawValue).boolValue
            let workTarget = WorkTargetModel(host: host, path: path, parametrs: parametrs, statusButton: statusButton)
            
            NetworkManager.shared.isPathOpen(for: uc) { [ weak self ] responseClo in
                if responseClo {
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: WvViewController.id)  as! WvViewController
                        vc.workTarget = workTarget
                        vc.statusWork = .done
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated: false, completion: nil)
                    }
                }
            }
            
        }
    }
}
// MARK: - Appsflyer Delegate
extension MainTableViewController: AppsFlyerLibDelegate {
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        guard let status = conversionInfo["af_status"] as? String else { return }
        var parametrs = "app_id=id\(DataManager.ProjectConstant.appId.rawValue)"
        parametrs += "&aftoken=\(DataManager.ProjectConstant.appsFlyerKey.rawValue)"
        parametrs += "&af_status=\(status)"
        parametrs += "&afid=\(AppsFlyerLib.shared().getAppsFlyerUID())"
        
        if status != "Organic" {
            
            if let name = conversionInfo["campaign"] as? String {
                parametrs += ParserName(dataName: name).getParametrs()
            }
            
            if let campaignId = conversionInfo["campaignId"] {
                parametrs += "&sub11=\(campaignId)"
            }
            
            if let source = conversionInfo["media_source"] {
                parametrs += "&media_source=\(source)"
            }
        }
        fetchRemoteConfig(for: parametrs)
    }
    
    func onConversionDataFail(_ error: Error) {
        let parametrs = "sub1=failedAppsflyer"
        fetchRemoteConfig(for: parametrs)
        print("tut failed data appsflyer")
    }
}

