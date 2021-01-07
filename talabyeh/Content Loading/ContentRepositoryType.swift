//
//  ContentRepositoryType.swift
//  talabyeh
//
//  Created by Hussein Work on 05/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Moya

protocol ContentRepositoryType {
    associatedtype ContentType
        
    func requestContent(completion: @escaping ContentRequestCompletion<ContentType>)
}


extension MoyaProvider {
    func request<ResultType: Codable>(_ endPoint: Target, _ mappedCompletion: @escaping ContentRequestCompletion<ResultType>){
        self.request(endPoint) { (result) in
            switch result {
            case .failure(let error):
                mappedCompletion(.failure(error))
            case .success(let response):
                do {
                    let result = try response.map(ResponseContainer<ResultType>.self)
                    
                    if let results = result.results {
                        mappedCompletion(.success(results))
                    } else {
                        mappedCompletion(.failure(MoyaError.requestMapping("No results where found")))
                    }
                } catch {
                    mappedCompletion(.failure(error))
                }
            }
        }
    }
}
