//
//  AddedGameDelegate.swift
//  Forabet Challenge
//
//  Created by BSergio on 03.04.2022.
//

import Foundation

public protocol AddedGameDelegate : NSObjectProtocol {
    
    func addPlayer()
    func getName(_ nameGame: String)
    func getPlayers(playerName: String, forId: Int)
    func getTypeGame(typeGame: Int)
    func getTimeSettings(minut: Int, seconds: Int)
    func getPoints(points: Int)
}
