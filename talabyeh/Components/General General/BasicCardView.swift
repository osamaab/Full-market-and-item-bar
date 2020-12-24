//
//  BasicCardView.swift
//  talabyeh
//
//  Created by Hussein Work on 14/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class BasicCardView: BasicViewWithSetup {

    var cornerRadius: CGFloat = 20 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    var maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner] {
        didSet {
            layer.maskedCorners = maskedCorners
        }
    }
    
    var hasShadow: Bool = true {
        didSet {
            self.layer.shadowOpacity = hasShadow ? 0.5 : 0
        }
    }

    override func setup() {
        dropShadow(color: DefaultColorsProvider.baseShadow.withAlphaComponent(0.16),
                   opacity: 0.5,
                   offSet: .init(width: 0, height: 3),
                   radius: 4)
    }
}
