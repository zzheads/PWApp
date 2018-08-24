//
//  RegisterViewController.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 24.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit
import Material

class RegisterViewController: UIViewController {
    fileprivate let usernameField = UIElements.textField("Username")
    fileprivate let emailField = UIElements.textField("Email")
    fileprivate let passwordField = UIElements.textField("Password", isPassword: true)
    fileprivate let registerButton = UIElements.raisedButton("Register")
    fileprivate let cancelButton = UIElements.raisedButton("Cancel")

    override func viewDidLoad() {
        super.viewDidLoad()
        UIElements.configureViewController(self)
        self.cancelButton.addTarget(self, action: #selector(self.cancelPressed(_:)), for: .touchUpInside)
        self.registerButton.addTarget(self, action: #selector(self.registerPressed(_:)), for: .touchUpInside)
        self.view.stackConfigure([self.usernameField, self.emailField, self.passwordField, self.registerButton, self.cancelButton], with: 16.0, xMargin: 32)
    }
}

extension RegisterViewController {
    @objc func cancelPressed(_ sender: RaisedButton) {
        self.dismiss(animated: true)
    }
    
    @objc func registerPressed(_ sender: RaisedButton) {
        guard let username = usernameField.text, let email = emailField.text, let password = passwordField.text, !username.isEmpty, !email.isEmpty, !password.isEmpty else { return }
        APIClient.default.register(username: username, email: email, password: password)
            .done { _ in self.showAlert(title: "User registered", message: "User with name: \(username), email: \(email), password: \(password) successfully registered", style: .alert) { self.dismiss(animated: true)} }
            .catch { error in self.showAlert(title: "API Error", message: error.localizedDescription, style: .alert)}
    }
}
