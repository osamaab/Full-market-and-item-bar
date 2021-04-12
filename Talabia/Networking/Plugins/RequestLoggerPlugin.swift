//
//  RequestLoggerPlugin.swift
//  talabyeh
//
//  Created by Hussein Work on 06/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Moya
//import OSLog

struct RequestLoggerPlugin: PluginType {
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        print("Request Response:")
        switch result {
        case .success(let response):
            print(response.request!.url as Any)

            
            if let json = try? response.mapJSON(), let asData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                print("Received an API Response: \(String(data: asData, encoding: .utf8) ?? "")")
            } else {
                let string = try? response.mapString()
                print("That's's strange, the response doesn't seem like JSON!: \(string)")
            }
            
            break
        case .failure(let error):
            print("API Error Received ( Internal ): \(error)")
            break
        }
    }
}
