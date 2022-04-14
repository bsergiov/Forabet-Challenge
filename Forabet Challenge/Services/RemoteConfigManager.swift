//
//  RemoteConfigManager.swift
//  Forabet Challenge
//
//  Created by BSergio on 14.04.2022.
//

import Firebase

class RemoteConfigManager {
    
   static let shared = RemoteConfigManager()
    
    private init() { }
    
    func fetchRemoteConfig(for parametrs: String,  completion: @escaping (_ networManager: WorkTargetModel?) -> Void) {
        let rc = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        rc.configSettings = settings
        rc.fetch(withExpirationDuration: 0) { status, error in
            guard error == nil else {
                print("Error fetch remote config \(String(describing: error))")
                completion(nil)
                return
            }
            rc.activate()
            if !rc.configValue(forKey: DataManager.ProjectConstant.keyStatus.rawValue).boolValue {
                completion(nil)
                return
            }
            
            guard let uc = rc.configValue(forKey: DataManager.ProjectConstant.keyCheck.rawValue).stringValue,
                  let host = rc.configValue(forKey: DataManager.ProjectConstant.keyHost.rawValue).stringValue,
                  let path = rc.configValue(forKey: DataManager.ProjectConstant.keyPath.rawValue).stringValue
            else {
                completion(nil)
                return
            }
            
            let statusButton = rc.configValue(forKey: DataManager.ProjectConstant.keyStatusButton.rawValue).boolValue
            let workTarget = WorkTargetModel(host: host, path: path, parametrs: parametrs, statusButton: statusButton)
            
            NetworkManager.shared.isPathOpen(for: uc) { responseClo in
                completion(responseClo ? workTarget : nil)
            }
        }
    }
}
