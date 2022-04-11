//
//  AddedGameCollectionReusableView.swift
//  Forabet Challenge
//
//  Created by SV on 01.04.2022.
//

import UIKit

class AddedGameCollectionReusableView: UICollectionReusableView {
    
    // MARK: - IB Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var addPlayer: UIButton!
    var delegate: AddedGameDelegate!
    
    @IBAction func tappedAddPlayer() {
        delegate.addPlayer()
    } 
}
