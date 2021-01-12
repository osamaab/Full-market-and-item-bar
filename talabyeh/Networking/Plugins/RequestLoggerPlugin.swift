//
//  RequestLoggerPlugin.swift
//  talabyeh
//
//  Created by Hussein Work on 06/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Moya

struct RequestLoggerPlugin: PluginType {
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        //TODO: Use the os.log to print out logs
        
    }
    
    func willSend(_ request: RequestType, target: TargetType) {
        print(request.request?.url)
    }
}
