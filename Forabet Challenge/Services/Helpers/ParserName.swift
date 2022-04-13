//
//  ParserName.swift
//  Forabet Challenge
//
//  Created by SV on 13.04.2022.
//

import Foundation

struct ParserName {
    let dataName: String
    
    func getParametrs() -> String {
        var finishParametr = "&triger=\(dataName)"
        finishParametr = finishParametr.replacingOccurrences(of: "||", with: "&")
        finishParametr = finishParametr.replacingOccurrences(of: "()", with: "=")
        
        return finishParametr
    }
}
