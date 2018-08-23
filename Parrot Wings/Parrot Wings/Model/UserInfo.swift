//
//  UserInfo.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 23.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Alamofire

class UserInfo: Codable {
    let id      : String
    let name    : String
    let email   : String
    let balance : Double
}

extension UserInfo {
    func loggedUser(_ token: Token) -> Resource<UserInfo> {
        return Resource<UserInfo>(endpoint: "api/protected/user-info", method: .get, headers: token.header)
    }
}
