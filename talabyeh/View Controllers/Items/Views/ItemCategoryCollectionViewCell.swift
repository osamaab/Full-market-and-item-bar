//
//  ItemCategoryCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 21/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class ItemCategoryCollectionViewCell: UICollectionViewCell {
    
    let titleLabel: UILabel = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        backgroundColor = DefaultColorsProvider.background1
        
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .font(for: .semiBold, size: 17)
        titleLabel.textColor = DefaultColorsProvider.darkerTint
        
        layer.cornerRadius = 12
        dropShadow(color: UIColor.lightGray,
                   opacity: 0.16,
                   offSet: .init(width: 0, height: 3.5),
                   radius: 3.5)
        
        titleLabel.fillHorizontally(padding: 20)
        titleLabel.fillVertically(padding: 10)
    }
}
