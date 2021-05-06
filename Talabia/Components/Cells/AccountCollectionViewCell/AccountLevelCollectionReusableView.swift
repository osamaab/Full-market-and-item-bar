//
//  AccountLevelCollectionReusableView.swift
//  Talabia
//
//  Created by Osama Abu hdba on 05/05/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class AccountLevelCollectionReusableView: UICollectionReusableView {
    
    
    let titleLabel: UILabel = .init()
    let stackView: UIStackView = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        backgroundColor = DefaultColorsProvider.tintSecondary
        layer.cornerRadius = 10
        dropShadow(color: .gray,
                      opacity: 0.3,
                                 offSet: .init(width: 0, height: 2),
                                 radius: 2)
        
        titleLabel.font = .font(for: .bold, size: 17)
        titleLabel.textColor = DefaultColorsProvider.tintPrimary

        subviewsPreparedAL {
            stackView
        }
        
        stackView.axis(.horizontal)
            .spacing(15)
            .distribution(.fill)
            .alignment(.center)

        stackView.addingArrangedSubviews {
            titleLabel
        }
        
        stackView.fillVertically(padding: 10).leading(15).trailing(>=20)
    }
        
       
    }

