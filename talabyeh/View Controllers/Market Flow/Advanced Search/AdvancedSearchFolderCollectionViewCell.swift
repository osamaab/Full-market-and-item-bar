//
//  AdvancedSearchFolderCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 18/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class AdvancedSearchFolderCollectionViewCell: ExpandableFolderItemCell {
    
    let titleLabel = UILabel()
    
    override func setup() {
        backgroundColor = isExpanded ? DefaultColorsProvider.lightTint : DefaultColorsProvider.itemBackground
        layer.cornerRadius = 12
        
        contentView.addSubview(titleLabel)
        
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = DefaultColorsProvider.darkerTint
        titleLabel.fillContainer(padding: 10)
    }
    
    override func expansionStateDidChange() {
        backgroundColor = isExpanded ? DefaultColorsProvider.lightTint : DefaultColorsProvider.itemBackground
    }
    
    override func titleDidChange() {
        titleLabel.text = title
    }
}
