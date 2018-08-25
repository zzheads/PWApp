//
//  MainViewController.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 24.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit
import Material

class MainViewController: UIViewController {
    var userInfo: UserInfo? { didSet { self.updateUserInfo(self.userInfo) } }
    var transactions: [Transaction] = [] { didSet { self.transactionsTableView.reloadData() } }
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var transactionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transactionsTableView.dataSource = self
        self.transactionsTableView.register(TransactionCell.nib, forCellReuseIdentifier: TransactionCell.identifier)
        self.transactionsTableView.rowHeight = UITableViewAutomaticDimension

        let attributes = [NSAttributedStringKey.font: UIElements.Font.bold(with: 12.0)!]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logoff", style: .plain, target: self, action: #selector(self.logoffPressed(_:)))
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes(attributes, for: .normal)
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes(attributes, for: .selected)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New transaction", style: .plain, target: self, action: #selector(self.transactionPressed(_:)))
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes(attributes, for: .normal)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes(attributes, for: .selected)

        APIClient.default.info()
            .done { self.userInfo = $0 }
            .catch { self.showAlert(title: "API Error", message: $0.localizedDescription, style: .alert) }
            .finally {
                APIClient.default.transactions()
                    .done({ self.transactions = $0.trans_token })
                    .catch({ print($0) })
            }
    }
}

extension MainViewController {
    func updateUserInfo(_ userInfo: UserInfo?) {
        guard let userInfo = userInfo else { return }
        self.navigationItem.title = "\(userInfo.name) (\(userInfo.email))"
        self.balanceLabel.text = String.init(format: "$%.2f", userInfo.balance)
    }
    
    @objc func logoffPressed(_ sender: FlatButton) {
        APIClient.default.logoff()
        self.navigationController?.popViewController(animated: true)
    }

    @objc func transactionPressed(_ sender: RaisedButton) {
        let transactionController = TransactionViewController()
        transactionController.userInfo = self.userInfo
        self.show(transactionController, sender: self)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactions.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.identifier, for: indexPath) as! TransactionCell
        cell.configure(with: self.transactions[indexPath.row])
        return cell
    }
}
