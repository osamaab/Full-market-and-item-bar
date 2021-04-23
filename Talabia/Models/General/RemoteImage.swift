//
//  RemoteImage.swift
//  talabyeh
//
//  Created by Hussein Work on 09/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct RemoteImage {
    let id: Int
    let url: URL?
}


extension RemoteImage: Codable { }
