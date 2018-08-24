//
//  TransactionCell.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 25.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit
import Material

class TransactionCell: UITableViewCell {
    static let identifier = "\(TransactionCell.self)"
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    func configure(with transaction: Transaction) {
        self.dateLabel.text = "\(transaction.date)"
        self.userLabel.text = transaction.username
        self.amountLabel.text = "$\(transaction.amount)"
        self.balanceLabel.text = "$\(transaction.balance)"
    }
}
