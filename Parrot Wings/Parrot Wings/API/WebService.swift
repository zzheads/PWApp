//
//  WebService.swift
//  Parrot Wings
//
//  Created by Алексей Папин on 23.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import Alamofire
import PromiseKit

final class WebService {
    static let `default` = WebService()
    
    private init() { }
    
    func fetchObject<T: Codable>(resource: Resource<T>) -> Promise<T> {
        return Promise<T>() { seal in
            resource.request.responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard let json = value as? JSON, let object = T(from: json) else { return }
                    seal.fulfill(object)
                    
                case .failure(let error):
                    seal.reject(self.apiError(error: error, response: response))
                }
            }
        }
    }
    
    func fetchArray<T: Codable>(resource: Resource<T>) -> Promise<[T]> {
        return Promise<[T]>() { seal in
            resource.request.responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard let json = value as? JSON, let objects = [T](from: json) else { return }
                    seal.fulfill(objects)
                    
                case .failure(let error):
                    seal.reject(self.apiError(error: error, response: response))
                }
            }
        }
    }
}

extension WebService {
    // Method to get correct reason why we have a error
    // Alamofire expect receive JSON but got simple text error message, like "Invalid user or password"
    // So we have update reason field in received error to
    // show user usefull info whats wrong
    
    func apiError(error: Error, response: DataResponse<Any>) -> NSError {
        let domain = "Parrot Wings API Error"
        var code = 410
        var userInfo = [NSLocalizedDescriptionKey: error.localizedDescription]
        if let data = response.data, let description = String(data: data, encoding: .utf8) {
            userInfo.updateValue(description, forKey: NSLocalizedDescriptionKey)
        }
        if let httpResponse = response.response {
            code = httpResponse.statusCode
        }
        return NSError(domain: domain, code: code, userInfo: userInfo)
    }
}
