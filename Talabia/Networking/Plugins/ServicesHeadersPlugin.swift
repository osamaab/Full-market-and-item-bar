//
//  ServicesHeadersPlugin.swift
//  talabyeh
//
//  Created by Hussein Work on 06/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Moya

struct ServicesHeadersPlugin: PluginType {
        
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {

        var request = request
        var defaultHeaders: [String: String] = [
            "Accepts": "application/json",
        ]
                
        if let language = Bundle.main.preferredLocalizations.first {
            defaultHeaders["Language"] = language
        }
        
        if let authToken = DefaultAuthenticationManager.shared.authToken {
            defaultHeaders["Authorization"] = "Token \(authToken)"
        }
        
        defaultHeaders["App-Version"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        
        defaultHeaders.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        return request
    }
}
