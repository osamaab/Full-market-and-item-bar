//
//  NewStoreLocationHeaderView.swift
//  talabyeh
//
//  Created by Hussein Work on 08/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class NewStoreLocationHeaderView: UICollectionReusableView {
    
    let titleLabel = UILabel().then {
        $0.font = .font(for: .semiBold, size: 17)
        $0.textColor = DefaultColorsProvider.tintPrimary
        $0.text = "Add location"
    }
    
    let plusButton = UIButton().then {
        $0.setImage(UIImage(named: "plus_small"), for: .normal)
        $0.tintColor = DefaultColorsProvider.tintPrimary
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        backgroundColor = DefaultColorsProvider.tintSecondary
        layer.cornerRadius = 10
        
        subviewsPreparedAL {
            titleLabel
            plusButton
        }
        
        titleLabel.leading(20).top(5).bottom(5)
        plusButton.trailing(20).centerVertically().height(15).width(15)
    }
}
