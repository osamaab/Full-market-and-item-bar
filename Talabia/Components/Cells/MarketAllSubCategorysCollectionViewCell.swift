//
//  MarketAllSubCategorysCollectionViewCell.swift
//  Talabia
//
//  Created by Osama Abu hdba on 13/04/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia
class MarketAllSubCategorysCollectionViewCell: UICollectionViewCell {
    
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
        }
        
       
        imageView.height(105)
        imageView.width(105)
        imageView.top(0).leading(0).trailing(0)

        titleLabel.centerHorizontally().leading(0)
        titleLabel.height(20)
        titleLabel.Top == imageView.Bottom + 7
        titleLabel.Bottom == Bottom
    }
}
