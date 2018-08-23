//
//  User.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 23.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Foundation
import Alamofire

class User: Codable {
    var username: String
    var email   : String
    var password: String
    
    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
}

extension User {
    var create: Resource<Token> {
        return Resource<Token>(endpoint: "users", method: .post, parameters: self.toJSON)
    }
    
    var login: Resource<Token> {
        return Resource<Token>(endpoint: "session/create", method: .post, parameters: ["username": self.username, "password": self.password])
    }
}


