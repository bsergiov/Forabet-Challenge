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
    
    // MARK: - Life Cicle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - IB Action
    @IBAction func contollGameTapped(_ sender: Any) {
    }
}
