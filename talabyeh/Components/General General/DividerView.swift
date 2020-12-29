//
//  DividerView.swift
//  talabyeh
//
//  Created by Hussein Work on 11/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class DividerView: BasicViewWithSetup {
    
    override func setup() {
        backgroundColor = DefaultColorsProvider.fieldBorder
    }
    
    override var intrinsicContentSize: CGSize {
        .init(width: Self.noIntrinsicMetric, height: 1)
    }
}
