//
//  FaildOperationCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 11/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class FaildOperationCollectionViewCell: DefaultOprationCollectionViewCell {
    
    override var backgroundType: BaseOprationCollectionViewCell.BackgroundType {
        .bordered(DefaultColorsProvider.error)
    }
    
    override func setup() {
        super.setup()
        
        headerView.statusImageView.image = UIImage(named: "operation-faild")
        headerView.timeLabel.textColor = DefaultColorsProvider.error
        headerView.timeTitleLabel.textColor = DefaultColorsProvider.error
    }
}
