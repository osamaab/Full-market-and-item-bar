//
//  AnyContentRepository.swift
//  talabyeh
//
//  Created by Hussein Work on 05/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct AnyContentRepository<ContentType>: ContentRepositoryType {
    fileprivate var base: Any
    fileprivate var requestContentBlock: ((@escaping ContentRequestCompletion<ContentType>) -> Void)
    
    init<Repository: ContentRepositoryType>(_ repository: Repository) where Repository.ContentType == ContentType {
        self.base = repository
        
        self.requestContentBlock = { completion in
            repository.requestContent(completion: completion)
        }
    }
    
    func requestContent(completion: @escaping ContentRequestCompletion<ContentType>) {
        self.requestContentBlock(completion)
    }
}

extension ContentRepositoryType {
    func eraseToAnyContentRepository() -> AnyContentRepository<Self.ContentType> {
        AnyContentRepository(self)
    }
}
