//
//  ActionButton.swift
//  talabyeh
//
//  Created by Hussein Work on 11/10/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class ActionButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        backgroundColor = DefaultColorsProvider.tintPrimary
        setTitleColor(DefaultColorsProvider.backgroundPrimary, for: .normal)
        titleLabel?.font = .font(for: .bold, size: 17)
    }
}
