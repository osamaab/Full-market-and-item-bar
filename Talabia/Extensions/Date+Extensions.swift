//
//  Date+Extensions.swift
//  talabyeh
//
//  Created by Hussein Work on 08/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

extension Date {
    var apiFormattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "en")
        formatter.dateFormat = "dd/MM/yyyy"

        return formatter.string(from: self)
    }
    
    var apiFormattedTime: String {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "en")
        formatter.dateFormat = "hh:mm a"
        

        return formatter.string(from: self)
    }
}
