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
    
    let containerView: UIView = .init()
    let titleLabel: UILabel = .init()
    let plusButton: UIButton = .init()
    let optionsButton: UIButton = .init()
    
    override func setup() {
        subviewsPreparedAL {
            containerView
            plusButton
        }
        
        containerView.subviewsPreparedAL {
            titleLabel
            optionsButton
        }
        
        containerView.backgroundColor = DefaultColorsProvider.lightTint
        containerView.layer.cornerRadius = 10
        
        plusButton.tintColor = DefaultColorsProvider.darkerTint
        plusButton.setImage(UIImage(named: "plus_small"), for: .normal)
        
        titleLabel.font = .font(for: .medium, size: 19)
        titleLabel.textColor = DefaultColorsProvider.darkerTint
        titleLabel.text = "Upload Certificate"
        
        optionsButton.setTitleColor(DefaultColorsProvider.darkerTint, for: .normal)
        optionsButton.titleLabel?.font = .font(for: .regular, size: 20)
        optionsButton.setTitle("...", for: .normal)
        
        containerView.leading(0).top(0).bottom(0)
        plusButton.trailing(0).centerVertically().width(20).height(20)
        plusButton.Leading == containerView.Trailing + 15
        
        titleLabel.leading(15).top(15).centerVertically()
        optionsButton.trailing(5).centerVertically()
        optionsButton.Leading >= titleLabel.Trailing + 15
    }
}

