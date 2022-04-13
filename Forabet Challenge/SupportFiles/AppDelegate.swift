//
//  AppDelegate.swift
//  Forabet Challenge
//
//  Created by BSergio on 30.03.2022.
//

import UIKit
import Firebase
import AppsFlyerLib

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initialionSDKs()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

// MARK: - Initialzation SDKs
extension AppDelegate {
    private func initialionSDKs() {
        
        FirebaseApp.configure()
        
        AppsFlyerLib.shared().appsFlyerDevKey = DataManager.ProjectConstant.appsFlyerKey.rawValue
        AppsFlyerLib.shared().appleAppID = DataManager.ProjectConstant.appId.rawValue
    }
}


