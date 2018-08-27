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
        return Promise<UserInfo>() { resolver in
            guard let token = self.token else {
                resolver.reject(AppError.notLogged.error)
                return
            }
            service.fetchObject(resource: UserInfo.loggedUser(token)).done({ resolver.fulfill($0) }).catch({ resolver.reject($0) })
        }
    }
    
    func transactions() -> Promise<TransactionsList> {
        return Promise<TransactionsList>() { resolver in
            guard let token = self.token else {
                resolver.reject(AppError.notLogged.error)
                return
            }
            self.service.fetchObject(resource: TransactionsList.transactions(token)).done({ resolver.fulfill($0) }).catch({ resolver.reject($0) })
        }
    }
    
    func users(filter: String) -> Promise<[UserShort]> {
        return Promise<[UserShort]>() { resolver in
            guard let token = self.token else {
                resolver.reject(AppError.notLogged.error)
                return
            }
            guard !filter.isEmpty else {
                resolver.reject(AppError.filterStringEmpty.error)
                return
            }
            self.service.fetchArray(resource: UserShort.filteredList(token, filter: filter)).done{resolver.fulfill($0)}.catch{resolver.reject($0)}
        }
    }
    
    func makeTransaction(username: String, amount: Double) -> Promise<TransactionToken> {
        return Promise<TransactionToken>() { resolver in
            guard let token = self.token else {
                resolver.reject(AppError.notLogged.error)
                return
            }
            self.service.fetchObject(resource: TransactionToken.createTransaction(token, name: username, amount: amount)).done{resolver.fulfill($0)}.catch{resolver.reject($0)}
        }
    }
}
