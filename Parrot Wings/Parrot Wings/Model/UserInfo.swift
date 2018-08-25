//
//  UserInfo.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 23.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Alamofire
import Material

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

extension UserInfo {
    static func buildAttributedString(_ strings: [String], attributes: [[NSAttributedStringKey: Any]]) -> NSAttributedString? {
        guard strings.count == attributes.count else {
            return nil
        }
        let result = NSMutableAttributedString(string: "")
        var count = 0
        for i in 0..<strings.count {
            result.append(NSAttributedString(string: strings[i]))
            let range = NSRange(location: count, length: result.length - count)
            result.addAttributes(attributes[i], range: range)
            count = result.length
        }
        return result
    }
}
