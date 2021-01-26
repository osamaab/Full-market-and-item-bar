//
//  ProfileMenuItemCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 25/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class ProfileMenuItemCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = .init()
    let titleLabel: UILabel = .init()
    let arrowImageView: UIImageView = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        imageView.tintColor = DefaultColorsProvider.tintPrimary
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.font = .font(for: .medium, size: 16)
        titleLabel.textColor = DefaultColorsProvider.textPrimary1

        arrowImageView.image = UIImage(named: "right-arrow")
        arrowImageView.tintColor = DefaultColorsProvider.elementUnselected
        arrowImageView.contentMode = .scaleAspectFit


        subviewsPreparedAL {
            imageView
            titleLabel
            arrowImageView
        }
        
        
        titleLabel.centerVertically()
        imageView.leading(20).height(44).width(44).centerVertically()
        titleLabel.Leading == imageView.Trailing + 8
        arrowImageView.trailing(20).height(12).width(12).centerVertically()

        
        if isRTL {
            arrowImageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
}