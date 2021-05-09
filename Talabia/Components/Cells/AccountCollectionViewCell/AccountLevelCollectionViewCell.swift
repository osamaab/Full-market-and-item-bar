//
//  AccountLevelCollectionViewCell.swift
//  Talabia
//
//  Created by Osama Abu hdba on 05/05/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class AccountLevelCollectionViewCell: UICollectionViewCell {
    
    
    let titleLabel = UILabel().then {
        $0.font = .font(for: .regular, size: 15)
        $0.textColor = DefaultColorsProvider.textPrimary1
        $0.textAlignment = .center
    }
    
    let checkbox = CheckDotView(frame: .zero).then {
        $0.isHidden = false
        
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
            titleLabel
            checkbox
        }
        
        checkbox.width(15).height(15).leading(5).centerVertically()
        titleLabel.centerVertically()
        titleLabel.Leading == checkbox.Trailing + 5
        titleLabel.height(20)
    }
}
