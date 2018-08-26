//
//  RegisterViewController.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 24.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var verifyField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Register"
        let attributes = [NSAttributedStringKey.font: UIElements.Font.bold(with: 12.0)!]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.backPressed(_:)))
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes(attributes, for: .normal)
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes(attributes, for: .selected)

        self.registerButton.addTarget(self, action: #selector(self.registerPressed(_:)), for: .touchUpInside)
    }
}

extension RegisterViewController {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    @objc func registerPressed(_ sender: UIButton) {
        guard let username = usernameField.text, let email = emailField.text, let password = passwordField.text, !username.isEmpty, !email.isEmpty, !password.isEmpty, let verify = self.verifyField.text else { return }
        guard password == verify else {
            self.showAlert(title: "User register error", message: "Fields password and verify password must be equal", style: .alert)
            return
        }
        guard self.isValidEmail(email) else {
            self.showAlert(title: "User register error", message: "Please enter valid email address", style: .alert)
            return
        }
        APIClient.default.register(username: username, email: email, password: password)
            .done { _ in self.showAlert(title: "User registered", message: "User with name: \(username), email: \(email), password: \(password) successfully registered", style: .alert) { self.dismiss(animated: true)} }
            .catch { error in self.showAlert(title: "API Error", message: error.localizedDescription, style: .alert)}
    }
    
    @objc func backPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
