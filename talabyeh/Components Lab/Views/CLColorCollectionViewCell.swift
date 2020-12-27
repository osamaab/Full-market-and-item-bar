//
//  CLColorCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 25/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CLColorCollectionViewCell: UICollectionViewCell {
    
    
    let titlesStackView: UIStackView = .init()
    let colorView: UIView = .init()
    
    let titleLabel: UILabel = .init()
    let subtitleLabel: UILabel = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        layer.cornerRadius = 5.4
        dropShadow(color: DefaultColorsProvider.decoratorShadow, opacity: 0.05, offSet: .init(width: 0, height: 3.4), radius: 3.4)

        titleLabel.font = .font(for: .semiBold, size: 16)
        titleLabel.textColor = DefaultColorsProvider.tintPrimary
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subtitleLabel.font = .font(for: .regular, size: 13)
        subtitleLabel.textColor = DefaultColorsProvider.textSecondary1
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        titlesStackView.addingArrangedSubviews {
            titleLabel
            subtitleLabel
        }
        
        titlesStackView.alignment(.fill).distribution(.fill).axis(.vertical).spacing(5)
        
        self.addSubview(titlesStackView)
        self.subviewsPreparedAL {
            colorView
            titlesStackView
        }
        
        colorView.backgroundColor = DefaultColorsProvider.tintPrimary
        colorView.layer.cornerRadius = 10
        
        colorView.width(45).height(45).centerVertically().leading(20)
        titlesStackView.Leading == colorView.Trailing + 15
        titlesStackView.top(15).trailing(20).centerVertically()
    }
}
