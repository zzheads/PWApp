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
                    seal.reject(self.detailedError(error: error, response: response))
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
                    seal.reject(self.detailedError(error: error, response: response))
                }
            }
        }
    }
}

extension WebService {
    func detailedError(error: Error, response: DataResponse<Any>) -> NSError {
        let description: String? = error.localizedDescription
        var reason: String? = nil
        guard let httpResponse = response.response else {
            if let data = response.data {
                reason = "\(self): \(String(data: data, encoding: .utf8) ?? "")"
            }
            return NSError.apiError(description: description, reason: reason)
        }
        if let data = response.data {
            reason = "\(self): \(String(data: data, encoding: .utf8) ?? "")"
        }
        return NSError.apiError(code: httpResponse.statusCode, description: description, reason: reason)
    }
}
