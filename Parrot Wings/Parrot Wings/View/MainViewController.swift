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
    let titleLabel = UIElements.label("")
    let logoffButton = UIElements.flatButton("Logoff")
    let transactionButton = UIElements.raisedButton("Make Transaction")
    let tableView = UITableView()
    let transactions = [
        "Transaction1",
        "Transaction2",
        "Transaction3",
        "Transaction4",
        "Transaction5",
        "Transaction6",
        "Transaction7",
        "Transaction8",
        "Transaction9",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIElements.configureViewController(self)
        self.view.layout(self.titleLabel).top(32).left(32).width(300)
        self.view.layout(self.logoffButton).right(32).width(50).top(28)
        self.view.layout(self.transactionButton).left(32).right(32).top(64)
        self.view.layout(self.tableView).left(32).right(32).top(96).bottom(-32)
        self.logoffButton.titleColor = Color.blueGrey.darken3
        self.tableView.backgroundColor = .green
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.reloadData()

        APIClient.default.info()
            .done { self.configure($0) }
            .catch { self.showAlert(title: "API Error", message: $0.localizedDescription, style: .alert) }
            .finally {
                APIClient.default.transactions()
                    .done({ print("Transactions:") ; print($0.trans_token) })
                    .catch({ print($0) })
            }
    }
}

extension MainViewController {
    func configure(_ userInfo: UserInfo) {
        let attributes = [
            [NSAttributedStringKey.font: UIElements.Font.bold(with: 16.0)!, NSAttributedStringKey.foregroundColor: Color.blue.darken4],
            [NSAttributedStringKey.font: UIElements.Font.regular(with: 12.0)!, NSAttributedStringKey.foregroundColor: Color.black, NSAttributedStringKey.baselineOffset: 1],
            [NSAttributedStringKey.font: UIElements.Font.bold(with: 16.0)!, NSAttributedStringKey.foregroundColor: Color.black],
            [NSAttributedStringKey.font: UIElements.Font.bold(with: 16.0)!, NSAttributedStringKey.foregroundColor: Color.black]
        ]
        self.titleLabel.attributedText = buildAttributedString([userInfo.name, " (\(userInfo.email))", " - ", "$\(userInfo.balance)"], attributes: attributes)
        self.titleLabel.textAlignment = .left
    }
    
    func buildAttributedString(_ strings: [String], attributes: [[NSAttributedStringKey: Any]]) -> NSAttributedString? {
        guard strings.count == attributes.count else {
            return nil
        }
        let result = NSMutableAttributedString(string: "")
        var count = 0
        for i in 0..<strings.count {
            result.append(NSAttributedString(string: strings[i]))
            let range = NSRange(location: count, length: result.length - count)
            result.addAttributes(attributes[i], range: range)
            count = result.length
        }
        return result
    }
}

extension MainViewController {
    @objc func logoffPressed(_ sender: FlatButton) {
        print("Log off")
    }

    @objc func transactionPressed(_ sender: RaisedButton) {
        print("Make Transaction")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.transactions[indexPath.row]
        return cell
    }
}
