//
//  APIContentRepository.swift
//  talabyeh
//
//  Created by Hussein Work on 05/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Moya

struct APIContentRepositoryType<APITarget: TargetType, ContentType: Codable>: ContentRepositoryType {
    
    let provider: MoyaProvider<APITarget>
    let target: APITarget
    
    init(_ target: APITarget){
        self.target = target
        self.provider = .default()
    }
    
    func requestContent(completion: @escaping ContentRequestCompletion<ContentType>) {
        self.provider.request(target, completion)
    }
}

struct APIError: LocalizedError {
    let message: String
    
    var errorDescription: String? {
        message
    }
}

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
