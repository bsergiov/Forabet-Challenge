//
//  WvViewController.swift
//  Forabet Challenge
//
//  Created by SV on 11.04.2022.
//

import UIKit
import WebKit

class WvViewController: UIViewController {
    
    static let id = "WvViewController"
    
    // MARK: - IB Outlets
    @IBOutlet weak var webV: WKWebView!
    @IBOutlet weak var toolbar: UIToolbar! {
        didSet {
            toolbar.isHidden = true
        }
    }
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    // MARK: - Public Properties
    var workUrl: DataManager.WorkPath!
    
    // MARK: - life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWv()
    }
    
    // MARK: - IB Action
    
}

// MARK: - Private Methodes
extension WvViewController {
    
    private func setupWv() {
        guard let url = URL(string: workUrl.rawValue) else { return }
        let request = URLRequest(url: url)
        webV.load(request)
    }
}
