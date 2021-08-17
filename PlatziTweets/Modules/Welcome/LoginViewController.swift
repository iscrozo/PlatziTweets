//
//  LoginViewController.swift
//  PlatziTweets
//
//  Created by Camilo Rozo on 15/08/21.
//

import UIKit
import NotificationBannerSwift

class LoginViewController: UIViewController {

    
    // MARK: - Referencias OUTLETS
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Referencias methods
    private func setupUI() {
        loginButton.layer.cornerRadius = 25
    }
    
    private func perfomLogin() {
        guard let emailValue = emailTextField.text, !emailValue.isEmpty else {
            NotificationBanner(title: "Ups!", subtitle: "Revisa tu campo de email", style: .warning).show()
            return
        }
        
        guard let passValue = passTextField.text, !passValue.isEmpty, passValue.count > 5 else {
            NotificationBanner(title: "Ups!", subtitle: "Revisa tu campo de password, tu password no cumple con los 5 caracteres minimos", style: .warning).show()
            return
        }
        
        
        performSegue(withIdentifier: Constants_segue.GO_TO_HOME, sender: nil)
    }
    
    // MARK: - Referencias ActionButtons
    @IBAction func loginButtonAction() {
        perfomLogin()
    }
}
