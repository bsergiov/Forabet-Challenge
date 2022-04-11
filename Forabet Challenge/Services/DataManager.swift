//
//  DataManager.swift
//  Forabet Challenge
//
//  Created by SV on 04.04.2022.
//

import Foundation

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
    
    enum WorkPath: String {
        case policy = "https://forabet-challenge.web.app/policy"
        case terms = "https://forabet-challenge.web.app/terms"
    }
}
