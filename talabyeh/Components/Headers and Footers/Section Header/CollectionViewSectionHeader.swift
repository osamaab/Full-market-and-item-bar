//
//  CollectionViewSectionHeader.swift
//  talabyeh
//
//  Created by Hussein Work on 22/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CollectionViewSectionHeader: UICollectionReusableView {

    lazy var seeMoreButton: UIButton = .init()
    lazy var titleLable: UILabel = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        subviews {
            titleLable
            seeMoreButton
        }
        
        titleLable.font = .font(for: .semiBold, size: 17)
        titleLable.textColor = DefaultColorsProvider.text
        
        seeMoreButton.titleLabel?.font = .font(for: .semiBold, size: 12)
        seeMoreButton.setTitleColor(DefaultColorsProvider.darkerTint, for: .normal)
        
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
        
        titleLable.leading(0).top(10)
        titleLable.centerVertically()
        
        seeMoreButton.trailing(0)
        seeMoreButton.CenterY == titleLable.CenterY
        seeMoreButton.Leading >= titleLable.Trailing
    }
}
