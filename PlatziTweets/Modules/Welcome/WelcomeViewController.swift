//
//  WelcomeViewController.swift
//  PlatziTweets
//
//  Created by Camilo Rozo on 15/08/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // MARK: - Referencias OUTLET
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    // MARK: Referencias Methods
    private func setupUI() {
        loginButton.layer.cornerRadius = 25
    }
    
}
