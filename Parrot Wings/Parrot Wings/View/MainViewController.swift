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
    var userInfo: UserInfo? { didSet { self.userInfoLabel = self.userInfo?.label } }
    var userInfoLabel: UILabel? = UIElements.label("")
    let logoffButton = UIElements.flatButton("Logoff")
    let transactionButton = UIElements.raisedButton("Make Transaction")
    let tableView = UITableView()
    var transactions: [Transaction] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIElements.configureViewController(self)
        self.view.layout(self.userInfoLabel!).top(32).left(32).width(300)
        self.view.layout(self.logoffButton).right(32).width(50).top(28)
        self.view.layout(self.transactionButton).left(32).right(32).top(64)
        self.view.layout(self.tableView).left(32).right(32).top(96).bottom(-32)
        self.logoffButton.titleColor = Color.blueGrey.darken3
        self.tableView.dataSource = self
        self.tableView.register(TransactionCell.nib, forCellReuseIdentifier: TransactionCell.identifier)
        self.logoffButton.addTarget(self, action: #selector(self.logoffPressed(_:)), for: .touchUpInside)
        self.transactionButton.addTarget(self, action: #selector(self.transactionPressed(_:)), for: .touchUpInside)

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
    @objc func logoffPressed(_ sender: FlatButton) {
        APIClient.default.logoff()
        self.dismiss(animated: true)
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
