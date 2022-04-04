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
    
    private func write(completion: () -> Void) {
        do {
            try realm.write { completion() }
        } catch  {
            print("Error write realm in db: \(error)")
        }
    }
}
