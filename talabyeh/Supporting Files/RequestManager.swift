//
//  RequestManager.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/15/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import Foundation
import Alamofire

class RequestManger: NSObject {
    
    static let shared = RequestManger()
    
    let decoder = JSONDecoder()
    
    func getUserTypes(completionHandler: @escaping (Types?, Error?) -> Void)
    {
        
        
        //        let url = URL(string: Constants.baseURL + "get_user_type")
        //        let request = URLRequest(url: url!)
        //        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        //
        //            print("response description: \(response.debugDescription)")
        //            guard let data = data else { return }
        //
        //            if let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]]{
        //
        //
        //            }
        //
        //
        //        }
        //        task.resume()
        
        AF.request(Constants.baseURL + "get_user_type").responseDecodable(of: Types.self) { response in
            
            //print(response)
            switch response.result
            {
            case .success:
                guard let types = response.value else { return }
                //print(types)
                completionHandler(types,response.error)
                break
            case .failure:
                completionHandler(nil, response.error)
                break
            }
        }
    }
    
    func getCategories(completionHandler: @escaping (Categories?, Error?) -> Void)
    {
        
        let headers: HTTPHeaders = HTTPHeaders(["lang":"ar"])
        AF.request(Constants.baseURL + "categories", method: .get, headers: headers).responseDecodable(of: Categories.self) { response in
            
            //print(response)
            switch response.result
            {
            case .success:
                guard let categories = response.value else { return }
                //print(categories)
                completionHandler(categories,response.error)
                break
            case .failure:
                completionHandler(nil, response.error)
                break
            }
        }
    }
    
    
}
