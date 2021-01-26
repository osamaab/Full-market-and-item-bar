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
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let checkbox = CheckboxView()
    
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
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true

        titleLabel.font = .font(for: .semiBold, size: 11)
        titleLabel.textColor = DefaultColorsProvider.textPrimary1
        
        checkbox.isHidden = true

        checkbox.width(20).height(20).top(15).trailing(15)
        
        imageView.height(100)
        imageView.Width == imageView.Height
        imageView.fillContainer()

        titleLabel.height(15).centerHorizontally()
        titleLabel.Top == imageView.Bottom + 10
        titleLabel.Bottom == Bottom
    }
}
