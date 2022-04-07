//
//  GameControllCollectionViewCell.swift
//  Forabet Challenge
//
//  Created by SV on 07.04.2022.
//

import UIKit

class GameControllCollectionViewCell: UICollectionViewCell {
    
    static let id = "GameControllCollectionViewCell"
    
    // MARK: - IB Outlets
    @IBOutlet weak var timePanel: UIView!
    
    @IBOutlet weak var startGameBtn: UIButton!
    @IBOutlet weak var finishGameBtn: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    // MARK: - Public Properties
    var delegate: GameDelegate!
    
    // MARK: - Life Cicle
    override func awakeFromNib() {
        super.awakeFromNib()
        finishGameBtn.isHidden = true
    }
    
    // MARK: - IB Action
    @IBAction func contollGameTapped(_ sender: UIButton) {
        if  sender.titleLabel?.text == "Start" {
            startGameBtn.setTitle("Stop game", for: .normal)
            delegate.changeStatusGame(currentStatus: true)
        }
        if sender.titleLabel?.text == "Stop game" {
            startGameBtn.setTitle("Start", for: .normal)
            delegate.changeStatusGame(currentStatus: false)
        }
        
    }
    
    // MARK: - Public Methodes
    func setupCell(game: GameModel, playerCell: GamePlayerPointCollectionViewCell) {

        timePanel.isHidden = game.typeGame == 1
    }
}
