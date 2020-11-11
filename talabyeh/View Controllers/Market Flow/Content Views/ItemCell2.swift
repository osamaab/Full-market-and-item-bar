//
//  ItemCell2.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import Stevia

class ItemCell2: UICollectionViewCell{
    
    let cView = UIView()
    let itemImage = UIImageView()
    let likeButton = UIButton()


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        
        self.subviews([cView,])
        
        cView.backgroundColor = DefaultColorsProvider.background
        cView.layer.borderWidth = 0.2
        cView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cView.layer.cornerRadius = 0.91
        cView.leading(0).trailing(0).top(0).height(130.16).centerHorizontally()
        
        // cView
        cView.subviews([itemImage, likeButton])
        itemImage.contentMode = .scaleAspectFit
        itemImage.image = itemImage.image?.withRenderingMode(.alwaysTemplate)
        itemImage.tintColor = UIColor(named: AdaptiveColors.white.rawValue)
        itemImage.width(100%).top(20.66).bottom(9.73).centerHorizontally()

        
        likeButton.setImage(UIImage(named: "heart"), for: .normal)
        likeButton.contentMode = .scaleAspectFit
        likeButton.trailing(8).height(17.92).width(20.03).top(7.23)
    }
}


