//
//  TransactionDetailsViewController.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 26.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit

class TransactionDetailsViewController: UIViewController {

    var userInfo    : UserInfo!
    var transaction : Transaction!
    
    @IBOutlet weak var balanceLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var correspondedLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var resultingBalanceLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes = [NSAttributedStringKey.font: UIElements.Font.bold(with: 12.0)!]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelPressed(_:)))
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes(attributes, for: .normal)
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes(attributes, for: .highlighted)
        
        self.copyButton.addTarget(self, action: #selector(self.copyPressed(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.userInfo.updateView(navigationItem: self.navigationItem, balanceLabel: self.balanceLabel)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyy"
        if let date = self.transaction.dateFormatted {
            self.dateLabel.text = dateFormatter.string(from: date)
        } else {
            self.dateLabel.text = self.transaction.date
        }
        self.correspondedLabel.text = self.transaction.username
        self.amountLabel.text = String.init(format: "$%.2f", self.transaction.amount)
        self.resultingBalanceLabel.text = String.init(format: "$%.2f", self.transaction.balance)
    }
}

extension TransactionDetailsViewController {
    @objc func cancelPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func copyPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: Segue.copy.rawValue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueId = segue.identifier else { return }
        if segueId == Segue.copy.rawValue {
            let transactionController = segue.destination as! TransactionViewController
            transactionController.userInfo = self.userInfo
            transactionController.transaction = self.transaction
        }
    }
}
