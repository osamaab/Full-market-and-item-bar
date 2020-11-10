//
//  RequestManager.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/15/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import Foundation
import Alamofire

//class RequestManger: NSObject {
//    
//    static let shared = RequestManger()
//    
//    let decoder = JSONDecoder()
//    
//    func getUserTypes(completionHandler: @escaping (Types?, Error?) -> Void) {
//        AF.request(Constants.baseURL + "get_user_type").responseDecodable(of: Types.self) { response in
//            
//            //print(response)
//            switch response.result
//            {
//            case .success:
//                guard let types = response.value else { return }
//                //print(types)
//                completionHandler(types,response.error)
//                break
//            case .failure:
//                completionHandler(nil, response.error)
//                break
//            }
//        }
//    }
//    
//    func getCategories(completionHandler: @escaping (Categories?, Error?) -> Void) {
//        
//        let headers: HTTPHeaders = HTTPHeaders(["lang":"ar"])
//        AF.request(Constants.baseURL + "categories", method: .get, headers: headers).responseDecodable(of: Categories.self) { response in
//            switch response.result
//            {
//            case .success:
//                guard let categories = response.value else { return }
//                //print(categories)
//                completionHandler(categories,response.error)
//                break
//            case .failure:
//                completionHandler(nil, response.error)
//                break
//            }
//        }
//    }
//    
//    
//}
