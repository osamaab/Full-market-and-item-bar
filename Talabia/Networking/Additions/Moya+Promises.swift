//
//  Moya+Promises.swift
//  talabyeh
//
//  Created by Hussein Work on 26/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Promises
import Moya

extension MoyaProvider {
    func request<ResultType: Codable>(_ endPoint: Target, _ mappedCompletion: @escaping ContentRequestCompletion<ResultType>){
        self.request(endPoint) { (result) in
            switch result {
            case .failure(let error):
                mappedCompletion(.failure(error))
            case .success(let response):
                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(ResponseContainer<ResultType>.self, from: response.data)
                    
                    if result.status.code < 200 || result.status.code >= 400 {
                        
                        
                        if let resultsAsString = result.results as? String {
                            mappedCompletion(.failure(APIError(message: resultsAsString)))
                        } else {
                            mappedCompletion(.failure(APIError(message: result.status.message)))
                        }
                        return
                    }
                    
                    if let results = result.results {
                        mappedCompletion(.success(results))
                    } else {
                        mappedCompletion(.failure(MoyaError.requestMapping("No results where found")))
                    }
                } catch {
                    let errorResult = try? decoder.decode(ResponseContainer<String>.self, from: response.data)
                    
                    if let result = errorResult?.results {
                        mappedCompletion(.failure(APIError(message: result)))
                    } else {
                        print("Internal Error Mapping: \(error)")
                        mappedCompletion(.failure(error))
                    }
                }
            }
        }
    }
}


extension MoyaProvider {
    func request<R: Codable>(_ target: Target, response: R.Type) -> Promise<R> {
        return Promise { success, failure in
            self.request(target) { (result: Result<R, Error>) in
                switch result {
                case .success(let object):
                    success(object)
                case .failure(let error):
                    failure(error)
                }
            }
        }
    }
}


struct APIError: LocalizedError {
    let message: String
    
    var errorDescription: String? {
        message
    }
}

extension TargetType {
    func request<R: Codable>(_ response: R.Type) -> Promise<R> {
        MoyaProvider<Self>.default().request(self, response: response)
    }
}

