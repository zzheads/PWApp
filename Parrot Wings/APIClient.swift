//
//  APIClient.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 24.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import PromiseKit
import Alamofire

final class APIClient {
    static let `default` = APIClient(WebService.default)

    let service : WebService
    var token   : Token?
    
    private init(_ webService: WebService) {
        self.service = webService
    }
    
    func login(email: String, password: String) -> Promise<Token> {
        return Promise<Token>() { seal in
            service.fetchObject(resource: User(username: "", email: email, password: password).login).done({ self.token = $0; seal.fulfill($0) }).catch({ seal.reject($0) })
        }
    }
    
    func logoff() {
        self.token = nil
    }
    
    func register(username: String, email: String, password: String) -> Promise<Token> {
        return Promise<Token>() { seal in
            service.fetchObject(resource: User(username: username, email: email, password: password).create).done({ seal.fulfill($0) }).catch({ seal.reject($0) })
        }
    }
    
    func info() -> Promise<UserInfo> {
        return Promise<UserInfo>() { seal in
            guard let token = self.token else {
                seal.reject(error("You can not get user info, you are not logged"))
                return
            }
            service.fetchObject(resource: UserInfo.loggedUser(token)).done({ seal.fulfill($0) }).catch({ seal.reject($0) })
        }
    }
    
    func transactions() -> Promise<TransactionsList> {
        return Promise<TransactionsList>() { seal in
            guard let token = self.token else {
                seal.reject(error("You can not get user info, you are not logged"))
                return
            }
            self.service.fetchObject(resource: TransactionsList.transactions(token)).done({ seal.fulfill($0) }).catch({ seal.reject($0) })
        }
    }
}

extension APIClient {
    fileprivate func error(_ description: String? = nil) -> NSError {
        return NSError(domain: "Parrot Wings APIClient Error", code: 400, userInfo: [NSLocalizedDescriptionKey: description as Any])
    }
}
