//
//  UploadCertificateView.swift
//  talabyeh
//
//  Created by Hussein Work on 14/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class UploadCertificateView: BasicViewWithSetup {
    
    let stackView: UIStackView = .init()
    let containerView: UIView = .init()
    let titleLabel: UILabel = .init()
    let plusButton: UIButton = .init()
    let optionsButton: UIButton = .init()
    
    override func setup() {
        subviewsPreparedAL {
            stackView
        }
        
        
        stackView.axis(.horizontal)
            .distribution(.fill)
            .alignment(.center)
            .spacing(15)
            .preparedForAutolayout()
        
        stackView.addingArrangedSubviews {
            containerView
            plusButton
        }
        
        containerView.subviewsPreparedAL {
            titleLabel
            optionsButton
        }
        
        containerView.backgroundColor = DefaultColorsProvider.tintSecondary
        containerView.layer.cornerRadius = 10
        
        plusButton.tintColor = DefaultColorsProvider.tintPrimary
        plusButton.setImage(UIImage(named: "plus-small"), for: .normal)
        
        titleLabel.font = .font(for: .medium, size: 16)
        titleLabel.textColor = DefaultColorsProvider.tintPrimary
        titleLabel.text = "Upload Certificate"
        
        optionsButton.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        optionsButton.titleLabel?.font = .font(for: .regular, size: 20)
        optionsButton.setTitle("...", for: .normal)
        
        stackView.fillContainer()
        plusButton.width(20).height(20)
        
        titleLabel.leading(15).top(15).centerVertically()
        optionsButton.trailing(5).centerVertically()
        optionsButton.Leading >= titleLabel.Trailing + 15
    }
}

