//
//  CheckDistributersOperationAccessoryView.swift
//  talabyeh
//
//  Created by Hussein Work on 13/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CheckDistributersOperationAccessoryView: BasicViewWithSetup {
    
    
    lazy var contentView: UIView = .init()
    lazy var cardView: CardContainerView = .init(title: nil, contentView: contentView)
    
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let mapButton = UIButton()
    
    override func setup() {
        clipsToBounds = false
        
        subviewsPreparedAL {
            cardView
        }
        
        cardView.fillContainer()
        
        contentView.subviewsPreparedAL {
            imageView
            titleLabel
            mapButton
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Group 2106")
        
        titleLabel.text = "Check Distributors"
        titleLabel.font = .font(for: .bold, size: 22)
        
        mapButton.layer.borderWidth = 1
        mapButton.layer.borderColor = DefaultColorsProvider.fieldBorder.cgColor
        mapButton.layer.cornerRadius = 2
        mapButton.backgroundColor = .lightGray
        
        imageView.leading(0).centerVertically().width(30).height(30).top(0)
        titleLabel.centerVertically()
        mapButton.trailing(0).centerVertically().width(30).height(30)
        
        titleLabel.Leading == imageView.Trailing + 15
        mapButton.Leading == titleLabel.Trailing + 15
    }
}
