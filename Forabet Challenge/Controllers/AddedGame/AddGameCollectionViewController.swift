//
//  AddGameCollectionViewController.swift
//  Forabet Challenge
//
//  Created by SV on 01.04.2022.
//

import UIKit

class AddGameCollectionViewController: UICollectionViewController {

    var players: [Player] = [Player(), Player()]
    
    var game = GameModel()
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uiNibCondition = UINib(nibName: ConditionCollectionViewCell.id, bundle: nil)
        collectionView.register(uiNibCondition, forCellWithReuseIdentifier: ConditionCollectionViewCell.id)
        
        let uiNibNameGame = UINib(nibName: NameGameNewGameCollectionViewCell.id, bundle: nil)
        collectionView.register(uiNibNameGame, forCellWithReuseIdentifier: NameGameNewGameCollectionViewCell.id)
        
        let uiNibPlayer = UINib(nibName: PlayerNewGameCollectionViewCell.id, bundle: nil)
        collectionView.register(uiNibPlayer, forCellWithReuseIdentifier: PlayerNewGameCollectionViewCell.id)
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
            dismiss(animated: true)
        }
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 3
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
    
    func getTimeSettings(minut: Int, seconds: Int) {
        game.timeMinute = minut
        game.timeSecond = seconds
        print("set min \(minut) and sec \(seconds)")
    }
    
    func getPlayers(playerName: String, forId: Int) {
        // TODO доработать модель под время и таймер
        players[forId].playerName = playerName
        print("tut player name \(playerName) for id \(forId)")
    }
    
    func addPlayer() {
        players.append(Player())
        collectionView.reloadData()
    }
    
    func getTypeGame(typeGame: Int) {
        game.typeGame = typeGame
    }
    
    func getPoints(points: Int) {
        game.pointsMax = points
    }
    
    func getName(_ nameGame: String) {
        game.nameGame = nameGame
    }
}
