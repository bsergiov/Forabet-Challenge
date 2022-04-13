//
//  WvViewController.swift
//  Forabet Challenge
//
//  Created by SV on 11.04.2022.
//

import UIKit
import WebKit

class WvViewController: UIViewController, WKNavigationDelegate {
    enum StatusWork {
        case done
        case polterm
    }
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
    var workUrl: DataManager.ProjectConstant!
    var workTarget: WorkTargetModel!
    var statusWork: StatusWork = .polterm
    
    // MARK: - life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWv()
        
        
    }
    
    // MARK: - IB Action
    @IBAction func backTapped(_ sender: UIBarButtonItem) {
        if webV.canGoBack {
            webV.goBack()
        }
    }
    
    @IBAction func refrechTapped(_ sender: UIBarButtonItem) {
        webV.reload()
    }
    
}

// MARK: - Private Methodes
extension WvViewController {
    
    private func setupToolBar() {
        toolbar.isHidden = workTarget.statusButton
    }
    
    private func setupSwipeBack() {
        let rightSwipe =  UISwipeGestureRecognizer(target: webV,
                                                   action: #selector(webV.goBack))
        rightSwipe.direction = .right
        webV.addGestureRecognizer(rightSwipe)
    }
    
    private func setupWv() {
      
        switch statusWork {
            
        case .done:
            setupToolBar()
            setupSwipeBack()
            let rightSwipe =  UISwipeGestureRecognizer(target: webV, action: #selector(webV.goBack))
            rightSwipe.direction = .right
            webV.addGestureRecognizer(rightSwipe)
            
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = workTarget.host
            urlComponents.path = workTarget.path
            urlComponents.query = workTarget.parametrs
            guard let urlDone = urlComponents.url else { return }
            startWv(for: urlDone)
        case .polterm:
            guard let url = URL(string: workUrl.rawValue) else { return }
            startWv(for: url)
        }
    }
    
    private func startWv(for url: URL) {
        let request = URLRequest(url: url)
        webV.load(request)
    }
}
