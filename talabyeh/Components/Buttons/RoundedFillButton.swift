//
//  RoundedFillButton.swift
//  talabyeh
//
//  Created by Hussein Work on 15/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class RoundedFillButton: RoundedButton {
    
    override func setup() {
        super.setup()
        
        layer.borderColor = DefaultColorsProvider.darkerTint.cgColor
        layer.borderWidth = 1
        
        backgroundColor = DefaultColorsProvider.lightTint
        setTitleColor(DefaultColorsProvider.darkerTint, for: .normal)
        titleLabel?.font = .font(for: .medium, size: 16)
    }
}
