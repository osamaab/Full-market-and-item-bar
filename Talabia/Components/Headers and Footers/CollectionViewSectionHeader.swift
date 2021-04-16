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
   public var onTouchComplitionHandler:(()-> Void)?
    
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
        
        titleLable.font = .font(for: .bold, size: 17)
        titleLable.textColor = DefaultColorsProvider.textPrimary1
        seeMoreButton.titleLabel?.font = .font(for: .regular, size: 15)
        seeMoreButton.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
        
        titleLable.leading(0).top(10)
        titleLable.centerVertically()
        
        seeMoreButton.trailing(5)
        seeMoreButton.CenterY == titleLable.CenterY
        seeMoreButton.Leading >= titleLable.Trailing
    }
}
