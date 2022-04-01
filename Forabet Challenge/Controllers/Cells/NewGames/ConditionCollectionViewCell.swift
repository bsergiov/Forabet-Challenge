//
//  ConditionCollectionViewCell.swift
//  Forabet Challenge
//
//  Created by SV on 01.04.2022.
//

import UIKit

class ConditionCollectionViewCell: UICollectionViewCell {

    static let id = "ConditionCollectionViewCell"
    
    
    // MARK: - IB Outlets
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pointsTf: UITextField!
    @IBOutlet weak var timeTf: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pointsTf.delegate = self
        timeTf.delegate = self
        
        
    }
    
    
    @IBAction func chooseGame(_ sender: UISegmentedControl) {
        
    }
}

extension ConditionCollectionViewCell: UITextFieldDelegate {
    
}
