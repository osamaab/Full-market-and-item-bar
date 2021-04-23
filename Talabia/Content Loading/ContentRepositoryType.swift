//
//  ContentRepositoryType.swift
//  talabyeh
//
//  Created by Hussein Work on 05/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

protocol ContentRepositoryType {
    associatedtype ContentType
        
    func requestContent(completion: @escaping ContentRequestCompletion<ContentType>)
}



