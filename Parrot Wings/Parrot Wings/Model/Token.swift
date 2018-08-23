//
//  Token.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 23.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Alamofire

class Token: Codable {
    let id_token    : String
    
    init(_ id_token: String) {
        self.id_token = id_token
    }
}

extension Token {
    var header: HTTPHeaders {
        return ["Authorization":"Bearer=\(self.id_token)"]
    }
}
