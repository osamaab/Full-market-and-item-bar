//
//  CartSummaryView.swift
//  talabyeh
//
//  Created by Hussein Work on 26/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CartSummaryView: UIView {
    
    let titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .font(for: .medium, size: 16)
    }
    
    let valueLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .font(for: .bold, size: 13)
        $0.textAlignment = .right
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        backgroundColor = DefaultColorsProvider.background
        
        subviews {
            titleLabel
            valueLabel
        }
        
        titleLabel.width(50%).leading(20).top(20)
        valueLabel.width(50%).trailing(20)
        
        valueLabel.CenterY == titleLabel.CenterY
        titleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
        
        titleLabel.text = "Subtotal ( 4 items )"
        valueLabel.text = "JD 430"
        
        layer.cornerRadius = 12
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        dropShadow(color: DefaultColorsProvider.baseShadow,
                   opacity: 0.16,
                   offSet: .init(width: 0, height: -2),
                   radius: 4)
    }
}
