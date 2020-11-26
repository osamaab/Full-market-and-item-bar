//
//  BorderedButton.swift
//  talabyeh
//
//  Created by Hussein Work on 11/10/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
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
        layer.borderWidth = 0.2
        layer.borderColor = DefaultColorsProvider.darkerTint.cgColor
        
        backgroundColor = DefaultColorsProvider.background
        setTitleColor(DefaultColorsProvider.darkerTint, for: .normal)
        titleLabel?.font = .font(for: .medium, size: 17)
    }
}
