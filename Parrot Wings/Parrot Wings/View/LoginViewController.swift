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
        self.loginButton.addTarget(self, action: #selector(self.loginPressed(_:)), for: .touchUpInside)
        self.registerButton.addTarget(self, action: #selector(self.registerPressed(_:)), for: .touchUpInside)
        self.rememberMeSwitch.addTarget(self, action: #selector(self.rememberMeSwitched(_:)), for: .valueChanged)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.saveDefaults()
    }
}

extension LoginViewController {
    @objc func loginPressed(_ sender: UIButton) {
        guard let email = self.emailField.text, let password = self.passwordField.text, !email.isEmpty, !password.isEmpty else { return }
        
        APIClient.default.login(email: email, password: password)
            .done { _ in self.performSegue(withIdentifier: Segue.main.rawValue, sender: self) }
            .catch { self.showAlert($0) }
    }
    
    @objc func registerPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: Segue.register.rawValue, sender: self)
    }
    
    @objc func rememberMeSwitched(_ sender: UISwitch) {
        if sender.isOn {
            self.saveDefaults()
        } else {
            self.clearDefaults()
        }
    }
}

