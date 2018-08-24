//
//  Token.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 23.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Alamofire

struct Token: Codable {
    let id_token    : String

    var header: HTTPHeaders {
        return ["Authorization": "Bearer \(self.id_token)"]
    }
}
