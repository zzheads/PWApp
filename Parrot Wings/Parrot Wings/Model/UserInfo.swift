//
//  UserInfo.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 23.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Alamofire

struct UserInfoToken: Codable {
    var id      : Int
    var name    : String
    var email   : String
    var balance : Double
}

struct UserInfo: Codable {
    var user_info_token: UserInfoToken
    
    var name: String {
        get { return self.user_info_token.name }
        set { self.user_info_token.name = newValue }
    }
    
    var email: String {
        get { return self.user_info_token.email }
        set { self.user_info_token.email = newValue }
    }
    
    var balance: Double {
        get { return self.user_info_token.balance }
        set { self.user_info_token.balance = newValue }
    }

    static func loggedUser(_ token: Token) -> Resource<UserInfo> {
        return Resource<UserInfo>(endpoint: "api/protected/user-info", method: .get, headers: token.header)
    }
}
