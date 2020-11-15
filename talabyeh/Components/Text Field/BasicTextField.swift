//
//  BasicTextField.swift
//  talabyeh
//
//  Created by Hussein Work on 15/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class BasicTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        font = .font(for: .medium, size: 15)
        textColor = DefaultColorsProvider.text
    }
}

