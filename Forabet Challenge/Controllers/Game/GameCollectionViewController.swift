//
//  GameCollectionViewController.swift
//  Forabet Challenge
//
//  Created by SV on 04.04.2022.
//

import UIKit

protocol GameDelegate {
    func changedPlayerPoint(idPlayer: Int, point: Int)
}

class GameCollectionViewController: UICollectionViewController {

    // MARK: - Public Properties
    var game: GameModel!
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = game.nameGame
        
        let conditionUinib = UINib(nibName: GameConditionCollectionViewCell.id, bundle: nil)
        collectionView.register(conditionUinib, forCellWithReuseIdentifier: GameConditionCollectionViewCell.id)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 1 ? game.players.count : 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameConditionCollectionViewCell.id, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GameCollectionReusableView.id, for: indexPath)
        
        guard let typedHeaderView = headerView as? GameCollectionReusableView else { return headerView }
        
        if indexPath.section == 0 {
            typedHeaderView.titleSectionLabel.text = "Conditions"
        }
        
        if indexPath.section == 1 {
            typedHeaderView.titleSectionLabel.text = "Points"
        }
        
        if indexPath.section == 3 {
            typedHeaderView.titleSectionLabel.isHidden = !(game.typeGame == 1)
           
//            typedHeaderView.titleSectionLabel.text = "Time"
        }
        
        return typedHeaderView
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
