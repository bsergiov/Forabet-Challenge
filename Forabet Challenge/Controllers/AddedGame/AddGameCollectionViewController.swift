//
//  AddGameCollectionViewController.swift
//  Forabet Challenge
//
//  Created by SV on 01.04.2022.
//

import UIKit
import SwiftUI

class AddGameCollectionViewController: UICollectionViewController {

    // MARK: - Public Properties
    var players: [Player] = [Player(), Player()]
    
    var game = GameModel()
    
    var delegate: MainDelegate!
    
    // MARK: - IB Outlets
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.isEnabled = false
        registatedCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    // MARK: - IB Action
    @IBAction func navigationButtonTapped(_ sender: UIBarButtonItem) {
        switch sender.title {
        case "Exit":
            dismiss(animated: true)
        default:
            // storage logic
            game.players.insert(contentsOf: players, at: 0)
            StorageManager.shared.save(game)
            delegate.newGame()
            dismiss(animated: true)
        }
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
         3
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        section == 2
        ? players.count
        : 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NameGameNewGameCollectionViewCell.id, for: indexPath) as! NameGameNewGameCollectionViewCell
            cell.delegate = self
            return cell
        }
        
        if indexPath.section == 1 {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConditionCollectionViewCell.id, for: indexPath) as! ConditionCollectionViewCell
            cell.delegate = self
            return cell
        }
        
        if indexPath.section == 2 {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerNewGameCollectionViewCell.id, for: indexPath) as! PlayerNewGameCollectionViewCell
            cell.delegate = self
            cell.cellId = indexPath.item
            cell.playerNameTf.placeholder = "\(players[indexPath.item].playerName) \(indexPath.item + 1)"
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AddedGameCollectionReusableView", for: indexPath)
            
            guard let typedHeaderView = headerView as? AddedGameCollectionReusableView else { return headerView }
            typedHeaderView.addPlayer.isHidden = true
            switch indexPath.section {
            case 0:
                typedHeaderView.isHidden = true
            case 1:
                typedHeaderView.headerLabel.text = "Condition"
            case 2:
                typedHeaderView.headerLabel.text = "Players"
                typedHeaderView.addPlayer.isHidden = false
                typedHeaderView.delegate = self
            default:
                assert(false, "Invalid element type")
            }
            return typedHeaderView
        default:
            assert(false, "Invalid element type")
        }
    }
}

// MARK: - Private Methodes
extension AddGameCollectionViewController {
    private func registatedCell() {
        let uiNibCondition = UINib(nibName: ConditionCollectionViewCell.id, bundle: nil)
        collectionView.register(uiNibCondition, forCellWithReuseIdentifier: ConditionCollectionViewCell.id)
        
        let uiNibNameGame = UINib(nibName: NameGameNewGameCollectionViewCell.id, bundle: nil)
        collectionView.register(uiNibNameGame, forCellWithReuseIdentifier: NameGameNewGameCollectionViewCell.id)
        
        let uiNibPlayer = UINib(nibName: PlayerNewGameCollectionViewCell.id, bundle: nil)
        collectionView.register(uiNibPlayer, forCellWithReuseIdentifier: PlayerNewGameCollectionViewCell.id)
    }
    
    private func checkFields() {
        doneButton.isEnabled = false
        
        for player in players {
            if player.playerName.isEmpty { return }
        }
        
        if game.nameGame.isEmpty { return }
        
        switch game.typeGame {
        case 0:
            if game.timeGame <= 0 { return }
        case 1:
            if game.pointsMax <= 0 { return }
        default:
            if game.timeGame <= 0 { return }
            if game.pointsMax <= 0 { return }
        }
        doneButton.isEnabled = true
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AddGameCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        var height: CGFloat = 50
        if indexPath.section == 1 {
            height = 223
        }
        return CGSize(width: width, height: height)
    }
}

// MARK: -  AddedGameDelegate
extension AddGameCollectionViewController: AddedGameDelegate {
    
    func setTimeSettings(timeGame: Int) {
        game.timeGame = timeGame
        checkFields()
    }
    
    func setPlayerName(playerName: String, forId: Int) {
        players[forId].playerName = playerName
        checkFields()
    }
    
    func addNewPlayer() {
        players.append(Player())
        collectionView.reloadData()
        checkFields()
    }
    
    func setTypeGame(typeGame: Int) {
        game.typeGame = typeGame
        checkFields()
    }
    
    func setGamePoints(points: Int) {
        game.pointsMax = points
        checkFields()
    }
    
    func setGameName(_ nameGame: String) {
        game.nameGame = nameGame
        checkFields()
    }
}
