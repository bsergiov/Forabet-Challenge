//
//  GamePlayerPointCollectionViewCell.swift
//  Forabet Challenge
//
//  Created by BSergio on 06.04.2022.
//

import UIKit

class GamePlayerPointCollectionViewCell: UICollectionViewCell {

    static let id = "GamePlayerPointCollectionViewCell"
    
    // MARK: - IB Outlets
    @IBOutlet weak var namePlayerLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    
    // MARK: - Public Properties
    var delegate: GameDelegate!
    var idPlayer: Int!
    var point: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Public Methodes
    func setupCell(idPlayer: Int, player: Player, currentStatusGame: Int) {
        self.idPlayer = idPlayer
        point = player.points
        namePlayerLabel.text = player.playerName
        pointsLabel.text = "\(player.points)"
        plusButton.isEnabled = currentStatusGame == 1
        minusButton.isEnabled = currentStatusGame == 1
        
    }
    
    // MARK: - IB Action
    @IBAction func changePointsTapped(_ sender: UIButton) {
        // minus
        if sender.tag == 0 {
            point -= 1
            point = point < 0 ? 0 : point
            
        }
        // plus
        if sender.tag == 1 {
            point += 1
        }
        delegate.changedPlayerPoint(idPlayer: idPlayer, point: point)
        pointsLabel.text = "\(point ?? 0)"
    }
    

}
