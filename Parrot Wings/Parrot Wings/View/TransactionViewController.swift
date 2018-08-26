//
//  TransactionViewController.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 25.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit
import SearchTextField

class TransactionViewController: UIViewController {
    var transaction     : Transaction?
    var userInfo        : UserInfo!
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var usernameField: SearchTextField!
    @IBOutlet weak var transferButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes = [NSAttributedStringKey.font: UIElements.Font.bold(with: 12.0)!]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelPressed(_:)))
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes(attributes, for: .normal)
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes(attributes, for: .selected)
        
        self.transferButton.addTarget(self, action: #selector(self.transferPressed(_:)), for: .touchUpInside)
        self.usernameField.addTarget(self, action: #selector(self.userValueChanged(_:)), for: .editingChanged)
        self.usernameField.theme = .lightTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.userInfo.updateView(navigationItem: self.navigationItem, balanceLabel: self.balanceLabel)
        guard let transaction = self.transaction else { return }
        self.amountField.text = "\(abs(transaction.amount))"
        self.usernameField.text = transaction.username
    }
}

extension TransactionViewController {
    @objc func cancelPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func transferPressed(_ sender: UIButton) {
        guard
            let amountString = self.amountField.text,
            let amount = Double(amountString),
            amount > 0,
            amount < self.userInfo.balance,
            let username = self.usernameField.text,
            !username.isEmpty
            else {
                self.showAlert(title: "Transaction error:", message: "Receiver username must be not empty, and amount of transaction must be more than 0 and less than your current balance", style: .alert)
                return
            }
        
        self.transferButton.isEnabled = false
        APIClient.default.makeTransaction(username: username, amount: amount)
            .done { transaction in
                self.userInfo.balance -= amount
                self.userInfo.updateView(navigationItem: self.navigationItem, balanceLabel: self.balanceLabel)
                self.showAlert(title: "Transaction complete", message: "Transaction:\n \(transaction.trans_token.date),\n\(transaction.trans_token.id),\n\(transaction.trans_token.username),\n\(transaction.trans_token.amount)\n is successfully completed", style: .alert) { self.performSegue(withIdentifier: "unwindToMainController", sender: self) }
            }
            .catch { error in self.showAlert(title: "API Error", message: error.localizedDescription, style: .alert) }
            .finally { self.transferButton.isEnabled = true }
    }

    @objc func userValueChanged(_ sender: UITextField) {
        guard let filter = self.usernameField.text, !filter.isEmpty else { return }
        self.usernameField.isEnabled = false
        APIClient.default.users(filter: filter)
            .done { users in self.usernameField.filterStrings(users.compactMap{$0.name}) }
            .catch { error in self.showAlert(title: "API Error", message: error.localizedDescription, style: .alert) }
            .finally {
                self.usernameField.isEnabled = true
                self.usernameField.becomeFirstResponder()
            }
    }
}

