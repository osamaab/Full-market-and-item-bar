//
//  MarketChangePasswordContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 24/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class MarketChangePasswordContentView: ChangePasswordContentView {
        
    let confirmButton: CircleConfirmButton = .init()
    
    override var containerPadding: UIEdgeInsets {
        .init(top: 20, left: 20, bottom: 30, right: 20)
    }
    
    override func setup() {
        super.setup()
        
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        backgroundColor = DefaultColorsProvider.background
        labelView.isHidden = true
        
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.subviewsPreparedAL {
            confirmButton
        }
        
        confirmButton.top(0).bottom(0).trailing(0)
        
        stackView.addArrangedSubview(containerView)
        
        dropShadow(color: DefaultColorsProvider.baseShadow,
                   opacity: 0.16,
                   offSet: .init(width: 0, height: 3.5), radius: 3.5)
    }
}
