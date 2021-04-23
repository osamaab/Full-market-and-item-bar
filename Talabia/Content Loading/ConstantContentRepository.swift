//
//  ConstantContentRepository.swift
//  talabyeh
//
//  Created by Hussein Work on 05/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct ConstantContentRepository<ContentType>: ContentRepositoryType {
    
    let result: Result<ContentType, Error>
    
    init(content: ContentType){
        self.result = .success(content)
    }
    
    init(error: Error){
        self.result = .failure(error)
    }
    
    init(result: Result<ContentType, Error>){
        self.result = result
    }
    
    func requestContent(completion: @escaping ContentRequestCompletion<ContentType>) {
        completion(self.result)
    }
}
