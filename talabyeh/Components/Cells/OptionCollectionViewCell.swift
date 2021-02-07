//
//  OptionCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 07/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class OptionCollectionViewCell: UICollectionViewCell {
    
    let containerStackView: UIStackView = .init()
    let imageView: UIImageView = .init()
    let titleLabel: UILabel = .init()
    let checkbox: CheckboxView = .init()
    let separatorView: DividerView = .init(axis: .horizontal)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        subviewsPreparedAL {
            containerStackView
            separatorView
            checkbox
        }
        
        containerStackView.addingArrangedSubviews {
            imageView
            titleLabel
        }
        
        containerStackView.leading(20).top(15).centerHorizontally()
        containerStackView.distribution(.fill).alignment(.center).axis(.horizontal).spacing(8)
        
        checkbox.trailing(20).centerVertically()
        
        separatorView.Leading >= containerStackView.Trailing
        separatorView.Trailing == checkbox.Leading
        
        separatorView.top(0).bottom(0)
        
        checkbox.height(25).width(25)
        
        
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        imageView.height(20).width(20)
        
        titleLabel.font = .font(for: .medium, size: 18)
        titleLabel.textColor = DefaultColorsProvider.textPrimary1
        
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = DefaultColorsProvider.decoratorBorder.cgColor
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.borderColor = DefaultColorsProvider.decoratorBorder.cgColor
    }
}
