//
//  FavoritsProductCollectionViewCell.swift
//  Talabia
//
//  Created by Osama Abu hdba on 26/04/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class FavoritsProductCollectionViewCell: UICollectionViewCell {
    
    let containerView = UIView().then {
        $0.backgroundColor = DefaultColorsProvider.backgroundPrimary
        $0.clipsToBounds = false
        $0.layer.masksToBounds = false
        
        $0.dropShadow(color: .gray,
                      opacity: 0.3,
                                 offSet: .init(width: 0, height: 2),
                                 radius: 2)
    }
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let likeButton = FavoriteButton()
    
    var onFavoriteButtonTapped: (() -> Void)?
    
    let topLabel = UILabel().then {
        $0.backgroundColor = DefaultColorsProvider.containerBackground1
        $0.textColor = DefaultColorsProvider.backgroundPrimary
        $0.layer.cornerRadius = 2
        $0.clipsToBounds = true
        $0.font = .font(for: .bold, size: 9)
        $0.textAlignment = .center
    }
    
    let subtitleLabel1 = UILabel().then {
        $0.font = .font(for: .regular, size: 13)
        $0.textColor = DefaultColorsProvider.textPrimary1
        $0.textAlignment = .left
    }
    
    let subtitleLabel2 = UILabel().then {
        $0.font = .font(for: .bold, size: 15)
        $0.textColor = DefaultColorsProvider.textPrimary1
    }

    
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
            subtitleLabel1
            subtitleLabel2
        }

        containerView.subviewsPreparedAL {
            imageView
            likeButton
            topLabel
        }
        
        containerView.leading(0).trailing(0).top(0)

        imageView.top(20).centerHorizontally()
        imageView.height(100).width(100%).centerHorizontally()
        
        topLabel.leading(8).top(8).height(15).width(28)

        likeButton.trailing(0).bottom(-5).height(40).width(40)
        
        
        subtitleLabel1.leading(0).centerHorizontally()
        subtitleLabel1.Top == containerView.Bottom + 8

        
        subtitleLabel2.leading(0).centerHorizontally()
        subtitleLabel2.Top == subtitleLabel1.Bottom + 5
        subtitleLabel2.bottom(15)
        
        likeButton.add(event: .touchUpInside) { [unowned self] in
            onFavoriteButtonTapped?()
        }
    }
}
