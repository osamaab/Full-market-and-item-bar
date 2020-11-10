//
//  Moya+DefaultProvidefr.swift
//  talabyeh
//
//  Created by Hussein Work on 11/10/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import Foundation
import Moya



extension TargetType {
    func request<R: Codable>(_ completion: @escaping ((Result<R, Error>) -> Void)) {
        MoyaProvider<Self>.default().request(self) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                do {
                    try completion(.success(response.map(R.self)))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}

extension MoyaProvider {
    static func `default`<T: TargetType>() -> MoyaProvider<T> {
        return MoyaProvider<T>()
    }
}
