//
//  AppError.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 27.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Alamofire

public enum AppError: Error {
    case notLogged
    case filterStringEmpty
    case serialization(message: String?)
    case api(error: Error, response: DataResponse<Any>)
}
