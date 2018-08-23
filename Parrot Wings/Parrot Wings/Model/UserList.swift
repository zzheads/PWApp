//
//  UserList.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 23.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Alamofire

class UserShort: Codable {
    let id  : String
    let name: String
}

extension UserShort {
    func filteredList(_ token: Token, filter: String) -> Resource<[UserShort]> {
        return Resource<[UserShort]>(endpoint: "api/protected/users/list", method: .post, parameters: ["filter": filter], headers: token.header)
    }
}
