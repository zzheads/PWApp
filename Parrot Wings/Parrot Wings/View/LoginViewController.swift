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
    fileprivate var usernameField: TextField!
    fileprivate var passwordField: TextField!
    fileprivate var loginButton: RaisedButton!
    fileprivate var registerButton: FlatButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension LoginViewController: TextFieldDelegate {
    func prepareView() {
        let margin: CGFloat = 32
        
        self.usernameField = TextField()
        self.usernameField.placeholder = "username"
        self.usernameField.detail = "Enter user name"
        self.usernameField.isClearIconButtonEnabled = true
        self.usernameField.delegate = self
        self.view.layout(self.usernameField).center(offsetY: -margin).left(margin).right(margin)
        
        self.passwordField = TextField()
        self.passwordField.placeholder = "password"
        self.passwordField.detail = "8 symbols at least"
        self.passwordField.isVisibilityIconButtonEnabled = true
        self.passwordField.isVisibilityIconButtonAutoHandled = true
        self.passwordField.delegate = self
        self.view.layout(self.passwordField).center(offsetY: self.usernameField.bounds.height + margin * 1.5).left(margin).right(margin)
        
        self.loginButton = RaisedButton(title: "Login", titleColor: Color.blue.darken4)
        self.loginButton.fontSize = 12
        self.view.layout(self.loginButton).center(offsetY: self.passwordField.bounds.height * 2 + margin * 3).left(margin).right(margin)
        self.loginButton.addTarget(self, action: #selector(self.loginPressed(_:)), for: .touchUpInside)
        
        self.registerButton = FlatButton(title: "Register new user", titleColor: Color.blue.lighten1)
        self.registerButton.fontSize = 11
        self.view.layout(self.registerButton).center(offsetY: self.passwordField.bounds.height * 2 + self.loginButton.bounds.height + margin * 4.5).left(margin).right(margin)
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as? ErrorTextField)?.isErrorRevealed = false
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = false
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = true
        return true
    }
}

extension LoginViewController {
    @objc func loginPressed(_ sender: RaisedButton) {
        guard let username = self.usernameField.text, let password = self.passwordField.text, !username.isEmpty, !password.isEmpty else { return }
        let loginToken = User(username: username, email: "", password: password).login
        WebService.default.fetchObject(resource: loginToken)
            .done { loginToken in
                print("Login token: \(loginToken)")
            }
            .catch { error in
                print("Error: \(error)")
            }
    }
}

