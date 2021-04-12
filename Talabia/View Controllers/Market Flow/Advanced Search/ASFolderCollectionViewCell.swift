//
//  ASFolderCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 18/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class ASFolderCollectionViewCell: ExpandableFolderItemCell {
    
    let titleLabel = UILabel()
    
    override func setup() {
        backgroundColor = isExpanded ? DefaultColorsProvider.tintSecondary : DefaultColorsProvider.containerBackground3
        layer.cornerRadius = 12
        
        contentView.addSubview(titleLabel)
        
        titleLabel.text = title
        titleLabel.font = .font(for: .semiBold, size: 17)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = DefaultColorsProvider.tintPrimary
        titleLabel.fillContainer(padding: 10)
    }
    
    override func expansionStateDidChange() {
        backgroundColor = isExpanded ? DefaultColorsProvider.tintSecondary : DefaultColorsProvider.containerBackground2
    }
    
    override func titleDidChange() {
        titleLabel.text = title
    }
}
