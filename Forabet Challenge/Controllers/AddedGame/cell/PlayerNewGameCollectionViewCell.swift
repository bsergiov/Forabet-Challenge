//
//  PlayerCollectionViewCell.swift
//  Forabet Challenge
//
//  Created by SV on 01.04.2022.
//

import UIKit

class PlayerNewGameCollectionViewCell: UICollectionViewCell {

    static let id = "PlayerNewGameCollectionViewCell"
    
    // MARK: - IB Outlets
    @IBOutlet weak var playerNameTf: UITextField!
    
    // MARK: - Public Properties
    var cellId: Int!
    var delegate: AddedGameDelegate!
    
    // MARK: - Life Cicle
    override func awakeFromNib() {
        super.awakeFromNib()
        playerNameTf.delegate = self
        setupBtnForTf()
    }
    
    // MARK: - Public Methodes
    func setupCell(forId: String) {
        playerNameTf.placeholder = forId
    }
}

// MARK: - Private methodes
extension PlayerNewGameCollectionViewCell {
    
    private func setupBtnForTf() {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        let buttonDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        let buttoCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([buttoCancel, spaceButton, buttonDone], animated: true)
        toolBar.isUserInteractionEnabled = true
        playerNameTf.inputAccessoryView = toolBar
    }
    
    @objc private func doneTapped() {
        cancelTapped()
    }
    
    @objc private func cancelTapped() {
        contentView.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension PlayerNewGameCollectionViewCell: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        delegate.getPlayers(playerName: textField.text ?? "", forId: cellId)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        doneTapped()
        return true
    }
}
