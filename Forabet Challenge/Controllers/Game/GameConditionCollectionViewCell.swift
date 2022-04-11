//
//  GameConditionCollectionViewCell.swift
//  Forabet Challenge
//
//  Created by SV on 05.04.2022.
//

import UIKit

class GameConditionCollectionViewCell: UICollectionViewCell {
    
    static let id = "GameConditionCollectionViewCell"
    
    // MARK: - IB Outlets
    @IBOutlet weak var descriptionConditionLabel: UILabel!
    
    // MARK: - Public Methodes
    func setupCell(game: GameModel) {
        var descriptionText = ""
        
        switch game.typeGame {
        case 0:
            descriptionText = "The winner is the one who scores more \(game.pointsMax) points in \(game.timeGame / 60) minutes \(game.timeGame % 60) seconds"
        case 1:
            descriptionText = "The winner is the one who scores \(game.pointsMax) points faster"
        default:
            descriptionText = "The winner is the one who scores \(game.pointsMax) points faster in \(game.timeGame / 60) minutes \(game.timeGame % 60) seconds"
        }
        descriptionConditionLabel.text = descriptionText
    }
}
