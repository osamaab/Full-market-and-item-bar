//
//  ProfileHeaderView.swift
//  talabyeh
//
//  Created by Hussein Work on 25/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class ProfileHeaderView: BasicViewWithSetup {
    
    let containerStackView: UIStackView = .init()
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = DefaultColorsProvider.backgroundPrimary
        $0.layer.cornerRadius = 50
        $0.clipsToBounds = true
    }
    
    let titleLabel = UILabel().then {
        $0.font = .font(for: .semiBold, size: 22)
        $0.textColor = DefaultColorsProvider.textPrimary1
    }
    
    let subtitleLabel = UILabel().then {
        $0.font = .font(for: .semiBold, size: 16)
        $0.textColor = DefaultColorsProvider.textSecondary1
    }
    
    let tertiaryLabel = UILabel().then {
        $0.textColor = DefaultColorsProvider.textSecondary1
        $0.font = .font(for: .regular, size: 13)
    }
    
//    let editButton = UIButton().then {
//        $0.tintColor = DefaultColorsProvider.tintPrimary
//        $0.setImage(.named("edit"), for: .normal)
//    }
    
    
    override func setup() {
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        dropShadow(color: .lightGray,
                   opacity: 0.16,
                   offSet: .init(width: 0, height: 3.4),
                   radius: 3.4)
        
        subviewsPreparedAL {
            containerStackView
//            editButton
        }
        
        containerStackView.addingArrangedSubviews {
            imageView
            titleLabel
            subtitleLabel
            tertiaryLabel
        }
        
        containerStackView
            .alignment(.center)
            .distribution(.fill)
            .spacing(5)
            .axis(.vertical)
        
        containerStackView.top(20).trailing(20).centerVertically().centerHorizontally()
        imageView.width(100).height(100)
//        editButton.top(20).trailing(15)
    }
}
