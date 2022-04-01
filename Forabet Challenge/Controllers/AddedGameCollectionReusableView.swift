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
    var currentPlayer = 2
    var completion: ((_ current: Int) -> Void)!
  
    
    
    @IBAction func tappedAddPlayer() {
        currentPlayer += 1
    }
    
    func changePlayer(completion: @escaping (_ count: Int) -> Void) {
        completion(currentPlayer)
    }
}
