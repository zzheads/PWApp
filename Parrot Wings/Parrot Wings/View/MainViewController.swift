//
//  MainViewController.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 24.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit

enum SortField: Int {
    case date       = 0
    case username   = 1
    case amount     = 2
    
    var title: String {
        switch self {
        case .date      : return "Date"
        case .username  : return "Username"
        case .amount    : return "Amount"
        }
    }
}

class MainViewController: UIViewController {
    var userInfo    : UserInfo? { didSet { self.userInfo?.updateView(navigationItem: self.navigationItem, balanceLabel: self.balanceLabel) } }
    var transactions: [Transaction] = [] { didSet { self.transactionsTableView.reloadData() } }
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var transactionsTableView: UITableView!
    @IBOutlet weak var sortControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transactionsTableView.dataSource = self
        self.transactionsTableView.delegate = self
        self.transactionsTableView.register(TransactionCell.nib, forCellReuseIdentifier: TransactionCell.identifier)
        self.transactionsTableView.rowHeight = 25

        let attributes = [NSAttributedStringKey.font: UIElements.Font.bold(with: 12.0)!]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logoff", style: .plain, target: self, action: #selector(self.logoffPressed(_:)))
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes(attributes, for: .normal)
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes(attributes, for: .selected)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New transaction", style: .plain, target: self, action: #selector(self.transactionPressed(_:)))
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes(attributes, for: .normal)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes(attributes, for: .selected)
        
        self.sortControl.addTarget(self, action: #selector(self.sortChanged(_:)), for: .valueChanged)
        self.sortControl.setTitleTextAttributes([NSAttributedStringKey.font: UIElements.Font.regular(with: 11.0)!], for: .normal)
        self.sortControl.setTitleTextAttributes([NSAttributedStringKey.font: UIElements.Font.regular(with: 11.0)!], for: .highlighted)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIClient.default.info()
            .done { self.userInfo = $0 }
            .catch { self.showAlert(title: "API Error", message: $0.localizedDescription, style: .alert) }
            .finally {
                APIClient.default.transactions()
                    .done({ self.transactions = $0.trans_token.sorted(by: {$0.date > $1.date}) })
                    .catch({ print($0) })
        }
    }
}

extension MainViewController {
    @objc func sortChanged(_ sender: UISegmentedControl) {
        guard let sort = SortField(rawValue: sender.selectedSegmentIndex) else { return }
        switch sort {
        case .date      : self.transactions.sort(by: { $0.date > $1.date })
        case .username  : self.transactions.sort(by: { $0.username.lowercased() <= $1.username.lowercased() })
        case .amount    : self.transactions.sort(by: { $0.amount > $1.amount })
        }
    }
    
    @objc func logoffPressed(_ sender: UIBarButtonItem) {
        APIClient.default.logoff()
        self.navigationController?.popViewController(animated: true)
    }

    @objc func transactionPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toTransaction", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueId = segue.identifier else { return }
        if segueId == "toTransaction" {
            let transferController = segue.destination as! TransactionViewController
            transferController.userInfo = self.userInfo
        }
        
        if segueId == "toTransactionDetails" {
            let detailsController = segue.destination as! TransactionDetailsViewController
            detailsController.userInfo = self.userInfo
            if let selectedIndexPath = self.transactionsTableView.indexPathForSelectedRow {
                detailsController.transaction = self.transactions[selectedIndexPath.row]
            }
        }
    }
    
    @IBAction func unwindToMainController(segue: UIStoryboardSegue) {
        
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toTransactionDetails", sender: self)
    }
}
