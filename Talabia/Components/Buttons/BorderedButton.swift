//
//  BorderedButton.swift
//  talabyeh
//
//  Created by Hussein Work on 11/10/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class BorderedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        layer.borderWidth = 1
        layer.borderColor = DefaultColorsProvider.tintPrimary.cgColor
        
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        titleLabel?.font = .font(for: .bold, size: 17)
    }
}
