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
        
        let playerPoinUinib = UINib(nibName: GamePlayerPointCollectionViewCell.id, bundle: nil)
        collectionView.register(playerPoinUinib, forCellWithReuseIdentifier: GamePlayerPointCollectionViewCell.id)
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
        
        let cellDefault = collectionView.dequeueReusableCell(withReuseIdentifier: GameConditionCollectionViewCell.id, for: indexPath)
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameConditionCollectionViewCell.id, for: indexPath) as! GameConditionCollectionViewCell
            cell.setupCell(game: game)
            return cell
        }
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamePlayerPointCollectionViewCell.id, for: indexPath) as! GamePlayerPointCollectionViewCell
            cell.delegate = self
            cell.setupCell(idPlayer: indexPath.item,
                           point: game.players[indexPath.item].points,
                           namePlayer: game.players[indexPath.item].playerName)
            return cell
            
        }
        
        return cellDefault
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
        
        if indexPath.section == 2 {
            typedHeaderView.titleSectionLabel.isHidden = true
        }
        return typedHeaderView
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GameCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        var height: CGFloat = 50
        if indexPath.section == 0 {
            height = 70
        }
        if indexPath.section == 1 {
            height = 50
        }
        return CGSize(width: width, height: height)
    }
}

// MARK: - GameDelegate
extension GameCollectionViewController: GameDelegate {
    func changedPlayerPoint(idPlayer: Int, point: Int) {
        print("tut idPlayer: \(idPlayer) and point \(point)")
    }
}
