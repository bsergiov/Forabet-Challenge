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
    var valueTest: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Public Methodes
    func setupCell(forId: String) {
        playerNameTf.placeholder = forId
    }

}
