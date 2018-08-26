//
//  TransactionCell.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 25.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
    static let identifier = "\(TransactionCell.self)"
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    func configure(with transaction: Transaction) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        if let date = transaction.dateFormatted {
            self.dateLabel.text = dateFormatter.string(from: date)
        } else {
            self.dateLabel.text = "\(transaction.date)"
        }
        self.userLabel.text = transaction.username
        self.amountLabel.text = String.init(format: "$%.2f", transaction.amount)
        self.balanceLabel.text = String.init(format: "$%.2f", transaction.balance)
        if transaction.amount > 0 {
            self.amountLabel.textColor = .green
        } else {
            self.amountLabel.textColor = .red
        }
    }
}
