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
                    guard let json = value as? JSON else {
                        seal.reject(NSError(domain: "", code: 410, userInfo: [NSLocalizedDescriptionKey:"Serialization error, value: \(value) is not json"]))
                        return
                    }
                    guard let object = T(from: json) else {
                        seal.reject(NSError(domain: "", code: 410, userInfo: [NSLocalizedDescriptionKey:"Serialization error, can't parse \(T.self) from json: \(json)"]))
                        return
                    }
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
                    guard let json = value as? [JSON] else {
                        seal.reject(NSError(domain: "", code: 410, userInfo: [NSLocalizedDescriptionKey:"Serialization error, value: \(value) is not json array"]))
                        return
                    }
                    guard let objects = [T](json) else {
                        seal.reject(NSError(domain: "", code: 410, userInfo: [NSLocalizedDescriptionKey:"Serialization error, can't parse \([T].self) from json array: \(json)"]))
                        return
                    }
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
