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
