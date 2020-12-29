//
//  MarketCategoryCell.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class MarketCategoryCollectionViewCell: UICollectionViewCell{
    
    let cImage = UIImageView()
    let cTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {        
        self.subviews([cImage, cTitle])
        
        cImage.contentMode = .scaleAspectFill
        cImage.width(100%).height(92.12).top(0)
        
        cTitle.font = currentLanguage == .en ? getEnglishFont(11, .semiBold): getArabicFont(11, .heavy)
        cTitle.textColor = UIColor(named: AdaptiveColors.black.rawValue)
        cTitle.height(15).centerHorizontally()
        cTitle.Top == cImage.Bottom + 9.57
        
        cImage.layer.cornerRadius = 15
        cImage.clipsToBounds = true
    }
}
