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
    var date    : String
    var username: String
    var amount  : Double
    var balance : Double
    
    var dateFormatted: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: self.date) else {
            print("Cant covert \(self.date) to date")
            return nil
        }
        return date
    }
}

struct TransactionToken: Codable {
    var trans_token: Transaction

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

