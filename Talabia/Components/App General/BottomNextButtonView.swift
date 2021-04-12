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
        
        backgroundView.backgroundColor = DefaultColorsProvider.tintSecondary
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        nextButton.titleLabel?.font = .font(for: .bold, size: 17)
        nextButton.layer.borderWidth = 1.5
        nextButton.layer.borderColor = DefaultColorsProvider.tintPrimary.cgColor
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.contentEdgeInsets = .init(top: 12, left: 25, bottom: 12, right: 25)
        nextButton.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        
        backgroundView.fillContainer()
        backgroundView.height(84)
        nextButton.top(10).centerHorizontally().leading(60).bottom(25)
    }
}

class chooseUserTypeBottomNextButtonView: UIView {
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
        
        backgroundView.backgroundColor = DefaultColorsProvider.tintPrimary
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton.layer.borderWidth = 0
        nextButton.layer.borderColor = DefaultColorsProvider.tintPrimary.cgColor
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.contentEdgeInsets = .init(top: 12, left: 25, bottom: 12, right: 25)
        nextButton.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        nextButton.titleLabel?.font = .font(for: .bold, size: 17)
        backgroundView.fillContainer()
        backgroundView.height(80)
        nextButton.top(10).centerHorizontally().leading(60).bottom(25)
    }
}
