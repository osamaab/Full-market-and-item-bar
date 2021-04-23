//
//  SubCategoryCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class SubCategoryCollectionViewCell: UICollectionViewCell{
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    let titleLabel = UILabel().then {
        $0.font = .font(for: .regular, size: 15)
        $0.textColor = DefaultColorsProvider.textPrimary1
        $0.textAlignment = .center
    }
    
    let checkbox = CustomiseCheckboxView(frame: .zero).then {
        $0.isHidden = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {        
        subviewsPreparedAL {
            imageView
            titleLabel
            checkbox
        }
        
        checkbox.width(20).height(20).top(5).trailing(5)
        imageView.height(80%)
        imageView.width(100%)
        imageView.top(0).leading(0).trailing(0)

        titleLabel.centerHorizontally().leading(0)
        titleLabel.Top == imageView.Bottom + 8
        titleLabel.Bottom == Bottom
        titleLabel.height(20)
    }
}
