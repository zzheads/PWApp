//
//  ViewController.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 23.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    fileprivate let store = UserDefaults(suiteName: "Parrot Wings Application")
    fileprivate let emailKey = "email key"
    fileprivate let passKey = "password key"
    fileprivate let rememberKey = "remember key"
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Loading email/pass values if exists
        self.emailField.text = self.store?.value(forKeyPath: self.emailKey) as? String
        self.passwordField.text = self.store?.value(forKeyPath: self.passKey) as? String
        if let rememberMe = self.store?.value(forKeyPath: self.rememberKey) as? Bool {
            self.rememberMeSwitch.isOn = rememberMe
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Login"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Store login/pass if switch "Remember me" is on
        if self.rememberMeSwitch.isOn {
            self.store?.setValue(self.emailField.text, forKeyPath: self.emailKey)
            self.store?.setValue(self.passwordField.text, forKeyPath: self.passKey)
        } else {
            self.store?.setValue(nil, forKeyPath: self.emailKey)
            self.store?.setValue(nil, forKeyPath: self.passKey)
        }
        self.store?.setValue(self.rememberMeSwitch.isOn as Bool, forKeyPath: self.rememberKey)
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

