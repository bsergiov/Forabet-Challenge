//
//  NameGameNewGameCollectionViewCell.swift
//  Forabet Challenge
//
//  Created by SV on 01.04.2022.
//

import UIKit

class NameGameNewGameCollectionViewCell: UICollectionViewCell {

    static let id = "NameGameNewGameCollectionViewCell"
    
    // MARK: - IB Outlets
    @IBOutlet weak var nameGameTf: UITextField!
    
    // MARK: - Public Properties
    var delegate: AddedGameDelegate!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameGameTf.delegate = self
    }

}

extension NameGameNewGameCollectionViewCell: UITextFieldDelegate {
    //changed text field
    func textFieldDidChangeSelection(_ textField: UITextField) {
        delegate.getName(textField.text ?? "")
    }
}
