//
//  DataManager.swift
//  Forabet Challenge
//
//  Created by SV on 04.04.2022.
//

import Foundation

struct DataManager {
    
    
    
    
    static func getTimeSettings() -> [[Int]] {
        var minuts: [Int] = []
        var seconds: [Int] = []
        for i in 1...45 {
            minuts.append(i)
        }
        for i in 1...60 {
            seconds.append(i)
        }

        return [minuts, seconds]
    }
}
