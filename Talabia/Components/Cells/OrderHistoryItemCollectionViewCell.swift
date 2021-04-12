//
//  OrderHistoryItemCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 24/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class OrderHistoryItemCollectionViewCell: UICollectionViewCell {
    
    let titleLabel = UILabel().then {
        $0.font = .font(for: .semiBold, size: 17)
        $0.textColor = DefaultColorsProvider.tintPrimary
    }
    
    let arrowImageView: ArrowImageView = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        layer.cornerRadius = 12
        backgroundColor = DefaultColorsProvider.containerBackground3
        
        subviewsPreparedAL {
            titleLabel
            arrowImageView
        }
        
        
        arrowImageView.trailing(20).height(12).width(12).centerVertically()

        dropShadow(color: DefaultColorsProvider.decoratorShadow, opacity: 0.16, offSet: .init(width: 0, height: 3.5), radius: 3.5)
        
        titleLabel.fillVertically(padding: 10)
        titleLabel.fillHorizontally(padding: 20)
    }
}
