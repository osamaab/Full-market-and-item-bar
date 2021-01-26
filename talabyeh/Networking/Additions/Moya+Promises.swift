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


extension TargetType {
    func request<R: Codable>(_ response: R.Type) -> Promise<R> {
        MoyaProvider<Self>.default().request(self, response: response)
    }
}

