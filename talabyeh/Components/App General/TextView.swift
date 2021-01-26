//
//  TextView.swift
//  talabyeh
//
//  Created by Hussein Work on 15/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import IQKeyboardManager

class TextView: IQTextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        self.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.5
        self.layer.borderColor = DefaultColorsProvider.decoratorBorder.cgColor
        
        contentInset = .init(top: 10, left: 15, bottom: 10, right: 15)
    }
}
