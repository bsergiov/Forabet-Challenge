//
//  AddedGameDelegate.swift
//  Forabet Challenge
//
//  Created by BSergio on 03.04.2022.
//

import Foundation

public protocol AddedGameDelegate : NSObjectProtocol {
    
    func addNewPlayer()
    func setGameName(_ nameGame: String)
    func setPlayerName(playerName: String, forId: Int)
    func setTypeGame(typeGame: Int)
    func setTimeSettings(timeGame: Int)
    func setGamePoints(points: Int)
}
