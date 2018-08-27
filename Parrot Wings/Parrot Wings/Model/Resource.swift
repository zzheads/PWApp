//
//  Resource.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 23.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Alamofire

struct Resource<T: Codable> {
    let endpoint    : String
    let method      : HTTPMethod
    let parameters  : JSON?
    let encoding    : ParameterEncoding
    let headers     : HTTPHeaders?

    init(endpoint: String, method: HTTPMethod, parameters: JSON? = nil, encoding: ParameterEncoding = URLEncoding.httpBody, headers: HTTPHeaders? = nil) {
        self.endpoint = endpoint
        self.method = method
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers
    }
    
    var baseURL     : String {
        return "http://193.124.114.46:3001/"
    }
    
    var url         : URL {
        return URL(string: self.baseURL + self.endpoint)!
    }
    
    var request     : DataRequest {
        return Alamofire.request(self.url, method: self.method, parameters: self.parameters, encoding: self.encoding, headers: self.headers)
    }
}

