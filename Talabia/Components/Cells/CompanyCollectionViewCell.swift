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
        $0.layer.cornerRadius = 6

        $0.dropShadow(color: .gray,
                      opacity: 0.3,
                                 offSet: .init(width: 0, height: 2),
                                 radius: 2)
    }
    
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    let titleLabel = UILabel().then {
        $0.font = .font(for: .regular, size: 13)
        $0.textColor = .black
    }
    
    let likeButton = FavoriteButton().then{
        $0.isHidden = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setup() {
        subviewsPreparedAL {
            containerView
        }

        containerView.subviewsPreparedAL {
            imageView
//            titleLabel
            likeButton
        }
        
        
        containerView.fillContainer()
//        containerView.backgroundColor = .green
//        titleLabel.bottom(5).centerHorizontally()
//        titleLabel.Top == imageView.Bottom + 5

        imageView.height(70%).centerHorizontally()
        imageView.leading(0).trailing(0)
        imageView.top(24).bottom(10)
//        imageView.Bottom == titleLabel.Top
        likeButton.trailing(0).height(40).width(40).top(-3)
    }
}
