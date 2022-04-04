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
    @Persisted var time: String?
    @Persisted var pointsMax: Int?
    @Persisted var players: List<Player>
}

class Player: Object {
    @Persisted var playerName = "Player "
}
