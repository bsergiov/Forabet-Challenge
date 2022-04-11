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
    
    // MARK: - IB Action
    @IBAction func contollGameTapped(_ sender: UIButton) {
        if  sender.titleLabel?.text == "Start" {
            delegate.changeStatusGame(currentStatus: 1)
        }
        if sender.titleLabel?.text == "Pause" {
            delegate.changeStatusGame(currentStatus: 0)
        }
        if sender.titleLabel?.text == "Finish Game" {
            delegate.finishGame()
        }
    }
    
    // MARK: - Public Methodes
    func setupCell(game: GameModel, statusGame: Bool) {
        
        timePanel.isHidden = game.typeGame == 1
        startGameBtn.isHidden = game.currentStatusGame == 2
        finishGameBtn.isHidden = game.currentStatusGame == 0
        
        let titleStartButton = game.currentStatusGame == 0 ? "Start" : "Pause"
        startGameBtn.setTitle(titleStartButton, for: .normal)
        
        let minute = getFormatInt(for: (game.timeGame / 60))
        let seconds = getFormatInt(for: (game.timeGame % 60))
        
        timerLabel.text = "\(minute) : \(seconds)"
    }
    
    // MARK: -  Private Methodes
    private func getFormatInt(for number: Int) -> String {
        (0...9).contains(number)
        ? "0\(number)"
        : "\(number)"
    }
}
