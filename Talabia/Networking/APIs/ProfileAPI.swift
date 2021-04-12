//
//  ProfileAPI.swift
//  talabyeh
//
//  Created by Hussein Work on 13/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Moya

struct CompanyAdditionalInfoInput: Codable {
    let bannerB64: String?
    let summary: String?
    let vision: String?
    let history: String?
    let more: String?
    let certificateB64: String?

    enum CodingKeys: String, CodingKey {
        case bannerB64 = "banner_b64"
        case summary = "summary"
        case vision = "vision"
        case history = "history"
        case more = "more"
        case certificateB64 = "certificate_b64"
    }
}

enum ProfileAPI: TargetType {
    case profile
    
    case changePassword(String, String) // old pas, new pass
    case editAdditionalInfo(CompanyAdditionalInfoInput)
}

extension ProfileAPI {
    var path: String {
        switch self {
        case .profile:
            return "user/profile"
        case .changePassword:
            return "user/change_password"
        case .editAdditionalInfo:
            return "company/additional_info/edit"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .profile:
            return .get
        case .changePassword, .editAdditionalInfo:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .profile:
            return .requestPlain
        case .changePassword(let old, let new):
            return .requestParameters(parameters: ["password": old, "new_password": new], encoding: JSONEncoding.default)
        case .editAdditionalInfo(let input):
            return .requestJSONEncodable(input)
        }
    }
}
