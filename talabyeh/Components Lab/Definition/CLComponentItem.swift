//
//  CLComponentItem.swift
//  talabyeh
//
//  Created by Hussein Work on 18/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

struct CLComponentItem: CLItem {
    
    let previewComponent: CLComponentPreview.Type

    let id: String = UUID().uuidString
    
    var name: String {
        previewComponent.name
    }
}

extension CLComponentPreview {
    static func toComponentItem() -> CLComponentItem {
        .init(previewComponent: self)
    }
}
