//
//  NetworkConfiguration.swift
//  talabyeh
//
//  Created by Hussein Work on 11/10/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation


/**
 Aka. Server configuration.
 This provides us with the url for the current using server, eg. development, qc, or live.
 */
enum NetworkConfiguration: String {
    case base
    
    static var current: NetworkConfiguration {
        .base
    }
    
    var baseURL: URL {
        switch self {
        case .base:
            return URL(string: "http://www.talabyeh.com/api/")!
        }
    }
}

