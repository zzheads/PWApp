//
//  ViewController.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 23.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit
import Material

class LoginViewController: UIViewController {
    fileprivate let store = UserDefaults(suiteName: "Parrot Wings Application")
    fileprivate let emailKey = "email key"
    fileprivate let passKey = "password key"
    fileprivate let rememberKey = "remember key"
    
    fileprivate let emailField = UIElements.textField("Email")
    fileprivate let passwordField = UIElements.textField("Password", isPassword: true)
    fileprivate let rememberMeButton = UIElements.rememberMe()
    fileprivate let loginButton = UIElements.raisedButton("Login")
    fileprivate let registerButton = UIElements.flatButton("or Register new user")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Loading email/pass values if exists
        self.emailField.text = self.store?.value(forKeyPath: self.emailKey) as? String
        self.passwordField.text = self.store?.value(forKeyPath: self.passKey) as? String
        if let rememberMe = self.store?.value(forKeyPath: self.rememberKey) as? Bool {
            self.rememberMeButton.isSelected = rememberMe
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIElements.configureViewController(self)
        self.loginButton.addTarget(self, action: #selector(self.loginPressed(_:)), for: .touchUpInside)
        self.registerButton.addTarget(self, action: #selector(self.registerPressed(_:)), for: .touchUpInside)
        self.view.stackConfigure([self.emailField, self.passwordField, self.rememberMeButton, self.loginButton, self.registerButton], with: 16, xMargin: 32)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Store login/pass if button "Remember me" is selected
        if self.rememberMeButton.isSelected {
            self.store?.setValue(self.emailField.text, forKeyPath: self.emailKey)
            self.store?.setValue(self.passwordField.text, forKeyPath: self.passKey)
            self.store?.setValue(self.rememberMeButton.isSelected as Bool, forKeyPath: self.rememberKey)
        }
    }
}

extension LoginViewController {
    @objc func loginPressed(_ sender: RaisedButton) {
        guard let email = self.emailField.text, let password = self.passwordField.text, !email.isEmpty, !password.isEmpty else { return }
        APIClient.default.login(email: email, password: password)
            .done { _ in self.show(MainViewController(), sender: self) }
            .catch { self.showAlert(title: "API Error", message: $0.localizedDescription, style: .alert) }
    }
    
    @objc func registerPressed(_ sender: FlatButton) {
        self.show(RegisterViewController(), sender: self)
    }
}

