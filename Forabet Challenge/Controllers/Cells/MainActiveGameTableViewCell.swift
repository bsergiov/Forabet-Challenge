//
//  MainActiveGameTableViewCell.swift
//  Forabet Challenge
//
//  Created by SV on 31.03.2022.
//

import UIKit

class MainActiveGameTableViewCell: UITableViewCell {

    
    // MARK: - IB Outlets
    @IBOutlet weak var nameGame: UILabel!
    @IBOutlet weak var playersCount: UILabel!
    @IBOutlet weak var indicatorActive: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Publick Methodes
    func setupCellActiveGame(){
        // передаем модель и присваеваем лэйблам значения
    }
    
    func setupCellNonActiveGame() {
        indicatorActive.isHidden = true
    }
    
}
