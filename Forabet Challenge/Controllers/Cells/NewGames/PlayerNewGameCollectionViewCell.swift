//
//  PlayerCollectionViewCell.swift
//  Forabet Challenge
//
//  Created by SV on 01.04.2022.
//

import UIKit

class PlayerNewGameCollectionViewCell: UICollectionViewCell {

    static let id = "PlayerNewGameCollectionViewCell"
    
    // MARK: - IB Outlets
    @IBOutlet weak var playerNameTf: UITextField!
    
    // MARK: - Public Properties
    var cellId: Int!
    var delegate: AddedGameDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playerNameTf.delegate = self
        
        // Initialization code
    }
    
    // MARK: - Public Methodes
    func setupCell(forId: String) {
        playerNameTf.placeholder = forId
    }

}

extension PlayerNewGameCollectionViewCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        delegate.getPlayers(playerName: textField.text ?? "", forId: cellId)
    }
}