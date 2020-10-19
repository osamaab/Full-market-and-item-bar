//
//  UserType.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/15/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import Foundation

struct UserType: Codable {


    let id: Int?
    //let ar_name: String?
    //let en_name: String?
    let name: String?
    let logo: String?
  
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case ar_name
//        case en_name
//        case logo
//
//    }
}

struct Types: Codable {
  
  let results: [UserType]
  
//  enum CodingKeys: String, CodingKey {
//
//    case all
//  }
    
}

