//
//  CompanyCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 15/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CompanyCollectionViewCell: UICollectionViewCell {
    
    let containerView = UIView().then {
        $0.backgroundColor = DefaultColorsProvider.backgroundPrimary
        $0.clipsToBounds = false
        $0.layer.masksToBounds = false

        $0.dropShadow(color: DefaultColorsProvider.decoratorShadow,
                                 opacity: 0.16,
                                 offSet: .init(width: 0, height: 2),
                                 radius: 2)
    }
    
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    let titleLabel = UILabel().then {
        $0.font = .font(for: .medium, size: 12)
        $0.textColor = DefaultColorsProvider.tintPrimary
    }
    
    let likeButton = FavoriteButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        subviewsPreparedAL {
            containerView
        }

        containerView.subviewsPreparedAL {
            imageView
            titleLabel
            likeButton
        }
        
        
        containerView.leading(0).trailing(0).top(0).bottom(15)
        
        titleLabel.bottom(5).centerHorizontally()
        titleLabel.Top == imageView.Bottom + 5

        imageView.width(100%).top(20).centerHorizontally()                
        likeButton.trailing(8).height(20).width(20).top(8)
    }
}
