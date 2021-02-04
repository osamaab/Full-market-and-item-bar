//
//  Moya+DefaultProvidefr.swift
//  talabyeh
//
//  Created by Hussein Work on 11/10/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation
import Moya

extension MoyaProvider {
    static func `default`() -> MoyaProvider<Target> {
        return MoyaProvider<Target>(plugins: [
            ServicesHeadersPlugin(),
            RequestLoggerPlugin(),
            RetriableRequestPlugin()
        ])
    }
}

extension TargetType {
    var baseURL: URL {
        NetworkConfiguration.current.baseURL
    }
    
    var sampleData: Data {
        Data()
    }
    
    
    var headers: [String : String]? {
        [:]
    }
}
