//
//  AddGameCollectionViewController.swift
//  Forabet Challenge
//
//  Created by SV on 01.04.2022.
//

import UIKit



class AddGameCollectionViewController: UICollectionViewController {

    var players = ["player1", "player2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uiNibCondition = UINib(nibName: ConditionCollectionViewCell.id, bundle: nil)
        collectionView.register(uiNibCondition, forCellWithReuseIdentifier: ConditionCollectionViewCell.id)
        
        let uiNibNameGame = UINib(nibName: NameGameNewGameCollectionViewCell.id, bundle: nil)
        collectionView.register(uiNibNameGame, forCellWithReuseIdentifier: NameGameNewGameCollectionViewCell.id)
        
        let uiNibPlayer = UINib(nibName: PlayerNewGameCollectionViewCell.id, bundle: nil)
        collectionView.register(uiNibPlayer, forCellWithReuseIdentifier: PlayerNewGameCollectionViewCell.id)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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
            return cell
        }
        
        if indexPath.section == 1 {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConditionCollectionViewCell.id, for: indexPath) as! ConditionCollectionViewCell
            return cell
            
        }
        
        if indexPath.section == 2 {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerNewGameCollectionViewCell.id, for: indexPath) as! PlayerNewGameCollectionViewCell
            cell.playerNameTf.placeholder = players[indexPath.item]
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
                typedHeaderView.headerLabel.text = "Name Game"
            case 1:
                typedHeaderView.headerLabel.text = "Condition"
            case 2:
                typedHeaderView.headerLabel.text = "Players"
                typedHeaderView.addPlayer.isHidden = false
                typedHeaderView.changePlayer {[weak self] count in
                    
                    print(count)
                }
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
