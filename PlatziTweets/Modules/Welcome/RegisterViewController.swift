//
//  RegisterViewController.swift
//  PlatziTweets
//
//  Created by Camilo Rozo on 15/08/21.
//

import UIKit
import NotificationBannerSwift

class RegisterViewController: UIViewController {

    // MARK: - Referencias OUTLET
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var passConfirmTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Referencias methods
    private func setupUI() {
        registerButton.layer.cornerRadius = 25
    }
    
    private func perfomRegister() {
        guard let nicknameValue = nicknameTextField.text, !nicknameValue.isEmpty, nicknameValue.count < 25 else {
            NotificationBanner(title: "Ups!", subtitle: "Lo sentimos mira tu campo de nickname",style: .warning).show()
            return
        }
        guard let emailValue = emailTextField.text, !emailValue.isEmpty, emailValue.count < 25 else {
            NotificationBanner(title: "Ups!", subtitle: "Lo sentimos mira tu campo de email", style: .warning).show()
            return
        }
        guard let passValue = passTextField.text, !passValue.isEmpty, passValue.count < 25 else {
            NotificationBanner(title: "Ups!", subtitle: "Lo snentimos mira tu campo de password", style: .warning) .show()
            return
        }
        guard let passConfirmValue = passConfirmTextField.text, !passConfirmValue.isEmpty, passValue == passConfirmValue,  passConfirmValue.count < 25 else {
            NotificationBanner(title: "Ups!", subtitle: "Lo sentimos mira tu campo de confirmar contraseña", style: .warning).show()
            return
        }
        performSegue(withIdentifier: Constants_segue.GO_TO_HOME, sender: nil)
    }
    
    // MARK: - Referencias RegisterActionsButton
    @IBAction func registerActionButton() {
        perfomRegister()
    }
}
