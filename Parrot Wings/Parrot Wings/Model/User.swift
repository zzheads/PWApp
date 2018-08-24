//
//  User.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 23.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Foundation
import Alamofire

struct User: Codable {
    var username: String
    var email   : String
    var password: String

    var create: Resource<Token> {
        return Resource<Token>(endpoint: "users", method: .post, parameters: self.toJSON)
    }
    
    var login: Resource<Token> {
        return Resource<Token>(endpoint: "sessions/create", method: .post, parameters: ["email": self.email, "password": self.password])
    }
}


