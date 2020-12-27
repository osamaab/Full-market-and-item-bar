//
//  FinishedOperationCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 11/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class FinishedOperationCollectionViewCell: DefaultOprationCollectionViewCell {
    
    override var backgroundType: BaseOprationCollectionViewCell.BackgroundType {
        .solid(DefaultColorsProvider.tintSecondary)
    }
    
    override func setup() {
        super.setup()
        
        headerView.statusImageView.image = UIImage(named: "operation-success")
    }
}
