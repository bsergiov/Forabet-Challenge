//
//  StorageManager.swift
//  Forabet Challenge
//
//  Created by BSergio on 30.03.2022.
//

import Foundation
import RealmSwift

class StorageManager {
    
    static let shared = StorageManager()
    
    let realm = try! Realm()
    
    private init() { }
    
    func save(_ game: GameModel) {
        write {
            realm.add(game)
        }
    }
    
    func update(_ game: GameModel, for time: Int) {
        write {
            game.timeGame = time
        }
    }
    
    func update(_ game: GameModel, currentStatus: Int) {
        write {
            game.currentStatusGame = currentStatus
        }
    }
    
    func update(_ player: Player, point: Int) {
        write {
            player.points = point
        }
    }
    
    func delete(_ game: GameModel) {
        write {
            realm.delete(game.players)
            realm.delete(game)
        }
    }
    
    func fetchGame(completion: @escaping (Results<GameModel>) -> Void) {
        
        let games = realm.objects(GameModel.self)
        completion(games)
    }
    
    private func write(completion: () -> Void) {
        do {
            try realm.write { completion() }
        } catch  {
            print("Error write realm in db: \(error)")
        }
    }
}
