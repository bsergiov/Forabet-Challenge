//
//  NameGameNewGameCollectionViewCell.swift
//  Forabet Challenge
//
//  Created by SV on 01.04.2022.
//

import UIKit

class NameGameNewGameCollectionViewCell: UICollectionViewCell {

    // MARK: - ID Cell
    static let id = "NameGameNewGameCollectionViewCell"
    
    // MARK: - IB Outlets
    @IBOutlet weak var nameGameTf: UITextField!
    
    // MARK: - Public Properties
    var delegate: AddedGameDelegate!
    
    // MARK: - Life Cicle
    override func awakeFromNib() {
        super.awakeFromNib()
        nameGameTf.delegate = self
        setupBtnForTf()
    }
}

// MARK: - Private Methodes
extension NameGameNewGameCollectionViewCell {
    private func setupBtnForTf() {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        let buttonDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        let buttoCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([buttoCancel, spaceButton, buttonDone], animated: true)
        toolBar.isUserInteractionEnabled = true
        nameGameTf.inputAccessoryView = toolBar
    }
    
    @objc private func doneTapped() {
        guard let name = nameGameTf.text, !name.isEmpty else { return }
        
        delegate.getName(name)
        cancelTapped()
    }
    
    @objc private func cancelTapped() {
        contentView.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension NameGameNewGameCollectionViewCell: UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        delegate.getName(textField.text ?? "")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cancelTapped()
        return true
    }
}
