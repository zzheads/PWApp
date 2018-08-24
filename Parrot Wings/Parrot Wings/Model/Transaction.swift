//
//  Transaction.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 23.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Foundation
import Alamofire

struct Transaction: Codable {
    var id      : Int
    var date    : Date
    var username: String
    var amount  : Double
    var balance : Double
}

struct TransactionToken: Codable {
    var trans_token: Transaction
    
    var id: Int {
        get { return self.trans_token.id }
        set { self.trans_token.id = newValue }
    }

    var date: Date {
        get { return self.trans_token.date }
        set { self.trans_token.date = newValue }
    }
    
    var username: String {
        get { return self.trans_token.username }
        set { self.trans_token.username = newValue }
    }
    
    var amount: Double {
        get { return self.trans_token.amount }
        set { self.trans_token.amount = newValue }
    }
    
    var balance: Double {
        get { return self.trans_token.balance }
        set { self.trans_token.balance = newValue }
    }
    
    static func createTransaction(_ token: Token, name: String, amount: Double) -> Resource<TransactionToken> {
        return Resource<TransactionToken>(endpoint: "api/protected/transactions", method: .post, parameters: ["name": name, "amount": amount], headers: token.header)
    }
}

struct TransactionsList: Codable {
    let trans_token: [Transaction]
    
    static func transactions(_ token: Token) -> Resource<TransactionsList> {
        return Resource<TransactionsList>(endpoint: "api/protected/transactions", method: .get, headers: token.header)
    }
}

