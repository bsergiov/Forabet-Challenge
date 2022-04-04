//
//  ConditionCollectionViewCell.swift
//  Forabet Challenge
//
//  Created by SV on 01.04.2022.
//

import UIKit

class ConditionCollectionViewCell: UICollectionViewCell {

    enum DescriptionCondition: String {
        case point = "point"
        case time = "time description"
        case timeAndPoint = "timeAndPoint"
    }
    
    static let id = "ConditionCollectionViewCell"
    
    
    // MARK: - IB Outlets
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = DescriptionCondition.time.rawValue
        }
    }
    @IBOutlet weak var pointsTf: UITextField!
    
    // MARK: - Public Outlets
    var delegate: AddedGameDelegate!
    
    @IBOutlet weak var timeTf: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pointsTf.delegate = self
        timeTf.delegate = self
    }
    
    
    @IBAction func chooseGame(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            descriptionLabel.text = DescriptionCondition.time.rawValue
        case 1:
            descriptionLabel.text = DescriptionCondition.point.rawValue
        default:
            descriptionLabel.text = DescriptionCondition.timeAndPoint.rawValue
        }
    }
}

extension ConditionCollectionViewCell: UITextFieldDelegate {
    
}
