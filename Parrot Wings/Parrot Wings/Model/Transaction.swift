//
//  Transaction.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 23.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Foundation
import Alamofire

class Transaction: Codable {
    let id: String
    let date: Date
    let username: String
    let amount: Double
    let balance: Double
}

class TransactionToken: Codable {
    let trans_token: Transaction
}

class TransactionsList: Codable {
    let trans_token: [Transaction]
}

extension Transaction {   
    func transactions(_ token: Token) -> Resource<TransactionsList> {
        return Resource<TransactionsList>(endpoint: "api/protected/transactions", method: .get, headers: token.header)
    }
    
    func createTransaction(_ token: Token, name: String, amount: Double) -> Resource<TransactionToken> {
        return Resource<TransactionToken>(endpoint: "api/protected/transactions", method: .post, parameters: ["name": name, "amount": amount], headers: token.header)
    }
}
