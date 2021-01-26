//
//  UIView+Additions.swift
//  talabyeh
//
//  Created by Hussein Work on 11/10/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

extension UIView {
    func dropShadow(color: UIColor = .black,
                    opacity: Float = 0.5,
                    offSet: CGSize,
                    radius: CGFloat = 1) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
}
