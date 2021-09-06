//
//  RegisterViewController.swift
//  PlatziTweets
//
//  Created by Camilo Rozo on 15/08/21.
//

import UIKit
import NotificationBannerSwift
import Simple_Networking
import SVProgressHUD

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
        guard let emailValue = emailTextField.text, !emailValue.isEmpty  else {
            NotificationBanner(title: "Ups!", subtitle: "Lo sentimos mira tu campo de email", style: .warning).show()
            return
        }
        guard let passValue = passTextField.text, !passValue.isEmpty, passValue.count > 5 else {
            NotificationBanner(title: "Ups!", subtitle: "Lo snentimos mira tu campo de password", style: .warning) .show()
            return
        }
        guard let passConfirmValue = passConfirmTextField.text, !passConfirmValue.isEmpty, passValue == passConfirmValue,  passConfirmValue.count < 25 else {
            NotificationBanner(title: "Ups!", subtitle: "Lo sentimos mira tu campo de confirmar contraseña", style: .warning).show()
            return
        }
//        performSegue(withIdentifier: Constants_segue.GO_TO_HOME, sender: nil)
        // Crear request
        let request = RegisterRequest(email: emailValue, password: passValue, names: nicknameValue)
        // UIndicar la carga
        SVProgressHUD.show()
        // llamar al servicio
        
        SN.post(endpoint: Endpoints.register, model: request) {
            (response: SNResultWithEntity<LoginResponse, ErrorResponse> )in
            // cerramos la carga al usuario
            SVProgressHUD.dismiss()
            
            switch response {
            case .success(let aobResponse):
                //todo lo bueno
                self.performSegue(withIdentifier: Constants_segue.GO_TO_HOME, sender: nil)
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
    
    // MARK: - Referencias RegisterActionsButton
    @IBAction func registerActionButton() {
        perfomRegister()
    }
}
