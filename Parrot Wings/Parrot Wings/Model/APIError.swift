//
//  APIError.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 23.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Foundation

enum APIError: Error {
    static let domain = "Parrot Wings API Errors"
    
    case userExists
    case noLoginInfo
    case invalidLogin
    case UnauthorizedError
    case invalidUser
    case userNotFound
    case balanceExceeded
    case noSearchString
    case unexpected
    
    var description: String {
        switch self {
        case .userExists        : return "A user with that email already exists."
        case .noLoginInfo       : return "You must send username and password."
        case .invalidLogin      : return "Invalid email or password."
        case .UnauthorizedError : return "Unauthorized error."
        case .invalidUser       : return "Invalid user."
        case .userNotFound      : return "User not found."
        case .balanceExceeded   : return "Balance exceeded."
        case .noSearchString    : return "No search string."
        case .unexpected        : return "Unexpected error."
        }
    }
    
    var code: Int {
        switch self {
        case .userExists        : return 400
        case .noLoginInfo       : return 400
        case .invalidLogin      : return 401
        case .UnauthorizedError : return 401
        case .invalidUser       : return 401
        case .userNotFound      : return 400
        case .balanceExceeded   : return 400
        case .noSearchString    : return 401
        case .unexpected        : return 401
        }
    }
    
    var error: NSError {
        return NSError(domain: APIError.domain, code: self.code, userInfo: [NSLocalizedDescriptionKey: self.description, NSLocalizedFailureReasonErrorKey: self.description])
    }
}

extension NSError {
    static func apiError(code: Int = 410, description: String? = nil, reason: String? = nil) -> NSError {
        var userInfo = [String: String]()
        if let description = description {
            userInfo.updateValue(description, forKey: NSLocalizedDescriptionKey)
        }
        if let reason = reason {
            userInfo.updateValue(reason, forKey: NSLocalizedFailureReasonErrorKey)
        }
        return NSError(domain: APIError.domain, code: code, userInfo: userInfo)
    }
}
