//
//  ChooseLanguageBotton.swift
//  talabyeh
//
//  Created by Osama Abu hdba on 28/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class ChooseLanguageButton: UIButton {
    
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
        titleLabel?.font = UIFont(name: "DINNextLTW23-Bold", size: 22)!
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.layer.cornerRadius = 13
        
        
        contentEdgeInsets = .init(top: 0, left: 15, bottom: 8, right: 15)
        self.setTitle("Arabic".localization, for: .normal)
        self.titleEdgeInsets = .init(top: -3, left: 0, bottom: 0, right: 0)
    }
}
