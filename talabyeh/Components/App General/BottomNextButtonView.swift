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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
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
        nextButton.layer.borderColor = DefaultColorsProvider.darkTint.cgColor
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.contentEdgeInsets = .init(top: 10, left: 25, bottom: 10, right: 25)
        nextButton.setTitleColor(DefaultColorsProvider.darkTint, for: .normal)
        
        backgroundView.fillContainer()
        nextButton.top(15).centerHorizontally().leading(50)
        nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
    }
}
