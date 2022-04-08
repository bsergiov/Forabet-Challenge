//
//  GameCollectionViewController.swift
//  Forabet Challenge
//
//  Created by SV on 04.04.2022.
//

import UIKit

protocol GameDelegate {
    func changedPlayerPoint(idPlayer: Int, point: Int)
    func changeStatusGame(currentStatus: Bool)
}

class GameCollectionViewController: UICollectionViewController {

    // MARK: - Public Properties
    var game: GameModel!
    private var statusButton = false
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = game.nameGame
        
        let conditionUinib = UINib(nibName: GameConditionCollectionViewCell.id, bundle: nil)
        collectionView.register(conditionUinib, forCellWithReuseIdentifier: GameConditionCollectionViewCell.id)
        
        let playerPoinUinib = UINib(nibName: GamePlayerPointCollectionViewCell.id, bundle: nil)
        collectionView.register(playerPoinUinib, forCellWithReuseIdentifier: GamePlayerPointCollectionViewCell.id)
        
        let gameControllUinib = UINib(nibName: GameControllCollectionViewCell.id, bundle: nil)
        collectionView.register(gameControllUinib, forCellWithReuseIdentifier: GameControllCollectionViewCell.id)
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
        
        let cellCondition = collectionView.dequeueReusableCell(withReuseIdentifier: GameConditionCollectionViewCell.id, for: indexPath) as! GameConditionCollectionViewCell
        
        let cellPlayerPoint = collectionView.dequeueReusableCell(withReuseIdentifier: GamePlayerPointCollectionViewCell.id, for: indexPath) as! GamePlayerPointCollectionViewCell
        
        let cellGameControll = collectionView.dequeueReusableCell(withReuseIdentifier: GameControllCollectionViewCell.id, for: indexPath) as! GameControllCollectionViewCell
        
        switch indexPath.section {
        case 0:
            cellCondition.setupCell(game: game)
            return cellCondition
        case 1:
            cellPlayerPoint.delegate = self
            cellPlayerPoint.setupCell(idPlayer: indexPath.item,
                                      point: game.players[indexPath.item].points,
                                      namePlayer: game.players[indexPath.item].playerName, statusButton: statusButton)
            return cellPlayerPoint
        default:
            cellGameControll.setupCell(game: game, statusGame: statusButton)
            cellGameControll.delegate = self
            
            return cellGameControll
        }
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
        if indexPath.section == 2 {
            height = 280
        }
        return CGSize(width: width, height: height)
    }
}

// MARK: - GameDelegate
extension GameCollectionViewController: GameDelegate {
    func changeStatusGame(currentStatus: Bool) {
        statusButton.toggle()
        collectionView.reloadData()
    }
    
    func changedPlayerPoint(idPlayer: Int, point: Int) {
        print("tut idPlayer: \(idPlayer) and point \(point)")
    }
}
