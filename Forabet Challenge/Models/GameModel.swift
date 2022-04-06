//
//  GameModel.swift
//  Forabet Challenge
//
//  Created by BSergio on 30.03.2022.
//

import Foundation
import RealmSwift

class GameModel: Object {
    @Persisted var nameGame = ""
    @Persisted var typeGame = 0
    @Persisted var isComleted = false
    @Persisted var timeMinute = 0
    @Persisted var timeSecond = 0
    @Persisted var pointsMax = 0
    @Persisted var players: List<Player>
}

class Player: Object {
    @Persisted var playerName = "Player "
    @Persisted var isFavorite = false
    
}
