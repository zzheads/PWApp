//
//  UserDefaults +.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 27.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit

protocol LoginView {
    var emailField: UITextField! { get set }
    var passwordField: UITextField! { get set }
    var rememberMeSwitch: UISwitch! { get set }
    
    func loadDefaults()
    func saveDefaults()
}

extension LoginView {
    func loadDefaults() {
        emailField.text = UserDefaults.store?.email
        passwordField.text = UserDefaults.store?.password
        rememberMeSwitch.isOn = UserDefaults.store?.remember ?? false
    }
    
    func saveDefaults() {
        if rememberMeSwitch.isOn {
            UserDefaults.store?.email = emailField.text
            UserDefaults.store?.password = passwordField.text
            UserDefaults.store?.remember = rememberMeSwitch.isOn
        } else {
            UserDefaults.store?.email = nil
            UserDefaults.store?.password = nil
            UserDefaults.store?.remember = nil
        }
    }
}

extension UserDefaults {
    static let suiteName = "Parrot Wings defaults"
    static let store = UserDefaults(suiteName: suiteName)
    
    enum Keys: String {
        case email
        case password
        case remember
    }
    
    var email: String? {
        get { return UserDefaults.store?.value(forKey: Keys.email.rawValue) as? String }
        set { UserDefaults.store?.set(newValue, forKey: Keys.email.rawValue) }
    }

    var password: String? {
        get { return UserDefaults.store?.value(forKey: Keys.password.rawValue) as? String }
        set { UserDefaults.store?.set(newValue, forKey: Keys.password.rawValue) }
    }

    var remember: Bool? {
        get { return UserDefaults.store?.value(forKey: Keys.remember.rawValue) as? Bool }
        set { UserDefaults.store?.set(newValue, forKey: Keys.remember.rawValue) }
    }
}
