//
//  BottomNextButtonView.swift
//  talabyeh
//
//  Created by Hussein Work on 11/12/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class BottomNextButtonView: UIView {
    
    let backgroundView: UIView = .init()
    let nextButton: RoundedButton = .init()

    init(title: String? = nil) {
        super.init(frame: .zero)
        setup()
        nextButton.setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        addSubview(backgroundView)
        addSubview(nextButton)
        
        backgroundView.backgroundColor = DefaultColorsProvider.lightTint
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton.layer.borderWidth = 1.5
        nextButton.layer.borderColor = DefaultColorsProvider.darkerTint.cgColor
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.contentEdgeInsets = .init(top: 12, left: 25, bottom: 12, right: 25)
        nextButton.setTitleColor(DefaultColorsProvider.darkerTint, for: .normal)
        
        backgroundView.fillContainer()
        nextButton.top(15).centerHorizontally().leading(50)
        nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
    }
}
