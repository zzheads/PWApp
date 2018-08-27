//
//  ViewController.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 23.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginView {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadDefaults()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Login"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.saveDefaults()
    }
}

extension LoginViewController {
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
        case "toMainLogged"     : return true
        case "toRegister"       : return true
        case "toMainUnlogged"   :
            guard let email = self.emailField.text, let password = self.passwordField.text, !email.isEmpty, !password.isEmpty else { return false }
            APIClient.default.login(email: email, password: password)
                .done { _ in self.performSegue(withIdentifier: "toMainLogged", sender: self) }
                .catch { self.showAlert(title: "API Error", message: $0.localizedDescription, style: .alert) }
            return false

        default                 : return false
        }
    }
}

