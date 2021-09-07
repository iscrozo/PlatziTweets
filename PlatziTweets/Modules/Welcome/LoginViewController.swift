//
//  LoginViewController.swift
//  PlatziTweets
//
//  Created by Camilo Rozo on 15/08/21.
//

import UIKit
import NotificationBannerSwift
import Simple_Networking
import SVProgressHUD

class LoginViewController: UIViewController {

    
    // MARK: - Referencias OUTLETS
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var guardarUsuario: UISwitch!
    
    private let storage = UserDefaults.standard
    private var userData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDataUser()
    }
    
    // MARK: - Referencias methods
    private func setupUI() {
        loginButton.layer.cornerRadius = 25
    }
    
    private func setupDataUser() {
        self.userData = storage.bool(forKey: "userApp")
        
        if self.userData {
            emailTextField.text = storage.string(forKey: "emailApp")
            passTextField.text = storage.string(forKey: "passApp")
            guardarUsuario.isOn = true
        } else {
            storage.removeObject(forKey: "passApp")
            storage.removeObject(forKey: "emailApp")
            storage.removeObject(forKey: "userApp")
            guardarUsuario.isOn = false
        }
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
        
        if guardarUsuario.isOn {
            storage.setValue(emailValue, forKey: "emailApp")
            storage.setValue(passValue, forKey:  "passApp")
            storage.setValue(true, forKey: "userApp")
        }
        
        //performSegue(withIdentifier: Constants_segue.GO_TO_HOME, sender: nil)
        // crear request
        let request = LoginRequest(email: emailValue, password: passValue)
        
        // Iniciamos la carga
        SVProgressHUD.show()
        
        // llamar libreria de red
        SN.post(endpoint: Endpoints.login, model: request) {
            (response: SNResultWithEntity<LoginResponse, ErrorResponse> )in
            
            SVProgressHUD.dismiss()
            
            switch response {
            case .success(let aobResponse):
                //todo lo bueno
                self.performSegue(withIdentifier: Constants_segue.GO_TO_HOME, sender: nil)
                SimpleNetworking.setAuthenticationHeader(prefix: "", token: aobResponse.token)
                DispatchQueue.main.async {
                    NotificationBanner( subtitle: "Bienvenido \(aobResponse.user.names)", style: .success).show()
                }

            break
            case .error(let aobError):
                // todo lo malo
                NotificationBanner( subtitle: "Lo sentimos \(aobError.localizedDescription)", style: .warning).show()
            break
            case .errorResult(let aobEntity):
                // error no tan malo
                NotificationBanner( subtitle: "Lo sentimos \(aobEntity.error)", style: .warning).show()
            break
            }
        }
        
    }
    
    // MARK: - Referencias ActionButtons
    @IBAction func loginButtonAction() {
        perfomLogin()
    }
}
