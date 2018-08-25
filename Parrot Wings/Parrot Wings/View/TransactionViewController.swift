//
//  TransactionViewController.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 25.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit
import Material

class TransactionViewController: UIViewController {
    var userInfo        : UserInfo? { didSet {  } }
    var userInfoLabel   : UILabel?
    let cancelButton = UIElements.raisedButton("Cancel")
    let transactionButton = UIElements.raisedButton("Make Transaction")
    
    override func viewDidLoad() {
        var elements = [UIView]()
        if let userInfoLabel = self.userInfoLabel {
            self.view.layout(userInfoLabel).top(32).left(32).width(300)
            userInfoLabel.textAlignment = .left
            elements.append(userInfoLabel)
        }
        self.view.stackConfigure(elements + [self.cancelButton, self.transactionButton], with: 32, xMargin: 32)
        super.viewDidLoad()
        UIElements.configureViewController(self)
    }
}
