//
//  DistributorCheckboxCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 23/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class DistributorCheckboxCollectionViewCell: DistributerCollectionViewCell {
    
    var checkbox: UIImageView = .init()
    
    override var isSelected: Bool {
        didSet {
            checkbox.image = isSelected ? UIImage(named: "checkbox-big") : nil
        }
    }
    
    override func setup() {
        super.setup()
        
        // same as above, but hide the action buttons and add the checkbox to the actionsStackVi
        subviewsPreparedAL {
            checkbox
        }
        
        phoneActionView.isHidden = true
        locationActionView.isHidden = true
        arrowImageView.isHidden = true
        
        checkbox.layer.borderWidth = 1
        checkbox.layer.borderColor = DefaultColorsProvider.decoratorBorder.cgColor
        checkbox.layer.cornerRadius = 15
        checkbox.contentMode = .scaleAspectFit
        
        checkbox.width(30).height(30).trailing(25).centerVertically()
        
    }
}
