//
//  DataManager.swift
//  Forabet Challenge
//
//  Created by SV on 04.04.2022.
//


struct DataManager {
    // for data picker
    static func getTimeSettings() -> [[Int]] {
        var minuts: [Int] = []
        var seconds: [Int] = []
        for i in 1...60 {
            if i <= 45 {
                minuts.append(i)
            }
            seconds.append(i)
        }
        return [minuts, seconds]
    }
    
    enum ProjectConstant: String {
        case policy = "https://forabet-challenge.web.app/policy"
        case terms = "https://forabet-challenge.web.app/terms"
        case appsFlyerKey = "cBFVhV5kVKBDugtRQbUzM7"
        case appId = "1618822767"
        case keyCheck = "check"
        case keyHost = "host"
        case keyPath = "path"
        case keyStatus = "status"
        case keyStatusButton = "statusButton"
        case oneSignaKey = ""
    }
}
