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
    @IBOutlet weak var timeTf: UITextField!
    
    // MARK: - Public Properties
    var delegate: AddedGameDelegate!
    
    // MARK: - Private Properties
    private let picker = UIPickerView()
    
    private var timeSet = DataManager.getTimeSettings()
    
    var minut = 0
    var seconds = 0
   
    // MARK: - Life Cicle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        picker.delegate = self
        picker.dataSource = self
        
        setupButtonForTf()
        
        timeTf.inputView = picker
        
        pointsTf.delegate = self
        timeTf.delegate = self
        
        pointsTf.isHidden = true
    }
    
    @IBAction func chooseGame(_ sender: UISegmentedControl) {
    
        switch sender.selectedSegmentIndex {
        case 0: // Time
            descriptionLabel.text = DescriptionCondition.time.rawValue
            timeTf.isHidden = false
            pointsTf.isHidden = true
        case 1: // Points
            pointsTf.isHidden = false
            timeTf.isHidden = true
            descriptionLabel.text = DescriptionCondition.point.rawValue
        default: // Time & Points
            pointsTf.isHidden = false
            timeTf.isHidden = false
            descriptionLabel.text = DescriptionCondition.timeAndPoint.rawValue
        }
        delegate.setTypeGame(typeGame: sender.selectedSegmentIndex)
    }
}

// MARK: - Private Methodes
extension ConditionCollectionViewCell {
    private func setupButtonForTf(){
        let toolBarTime = UIToolbar()
        toolBarTime.barStyle = .default
        toolBarTime.sizeToFit()
        let buttonDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        let buttoCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        toolBarTime.setItems([buttoCancel, spaceButton, buttonDone], animated: true)
        toolBarTime.isUserInteractionEnabled = true
        timeTf.inputAccessoryView = toolBarTime
        
        let toolBarPoint = UIToolbar()
        toolBarPoint.barStyle = .default
        toolBarPoint.sizeToFit()
        let btnDonePoint = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTappedPoint))
        let btnCancelPoint = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        toolBarPoint.setItems([btnCancelPoint, spaceButton, btnDonePoint], animated: true)
        toolBarPoint.isUserInteractionEnabled = true
        pointsTf.inputAccessoryView = toolBarPoint
    }
    
    @objc private func doneTappedPoint() {
        guard let points = Int(pointsTf.text ?? ""), points > 0 else { return }
        
        delegate.setGamePoints(points: points)
        cancelTapped()
    }
    
    @objc private func doneTapped(){
        if minut == 0, seconds == 0 {
            return
        }
        let timeGame = minut * 60 + seconds
        delegate.setTimeSettings(timeGame: timeGame)
        cancelTapped()
    }
    
    @objc private func cancelTapped(){
        contentView.endEditing(true)
    }
}

extension ConditionCollectionViewCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case pointsTf:
            guard let maxPoints = Int(textField.text ?? "") else { return }
            delegate.setGamePoints(points: maxPoints)
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        contentView.endEditing(true)
    }
}

extension ConditionCollectionViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        timeSet.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        timeSet[component].count + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            if row == 0 {
                return "Minute"
            }
            return "\(timeSet[component][row - 1])"
        }
        
        if component == 1 {
            if row == 0 {
                return "Seconds"
            }
            return "\(timeSet[component][row - 1])"
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let index = row == 0 ? 0 : row - 1
        if component == 0 {
            minut = timeSet[0][index]
        }
        if component == 1 {
            seconds = timeSet[1][index]
        }
        timeTf.text = "Minut \(minut) second \(seconds)"
    }
}
