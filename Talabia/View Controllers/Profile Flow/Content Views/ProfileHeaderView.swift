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
    let preferencesManager = UserDefaultsPreferencesManager.shared
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = DefaultColorsProvider.backgroundPrimary
        $0.layer.cornerRadius = 50
        $0.clipsToBounds = true
        $0.layer.borderWidth = 50
        $0.layer.borderColor = .init(red: 1, green: 0, blue: 0, alpha: 0)
        $0.layer.masksToBounds = true
    }
    
    let titleLabel = UILabel().then {
        $0.font = .font(for: .bold, size: 22)
        $0.textColor = DefaultColorsProvider.textPrimary1
    }
    
    let subtitleLabel = UILabel().then {
        $0.font = .font(for: .regular, size: 17)
        $0.textColor = DefaultColorsProvider.textSecondary1
    }
    
    let tertiaryLabel = UILabel().then {
        $0.textColor = DefaultColorsProvider.textSecondary1
        $0.font = .font(for: .regular, size: 17)
    }
    
    let editButton = UIButton().then {
        $0.tintColor = DefaultColorsProvider.tintPrimary
        $0.setImage(.named("edit"), for: .normal)
    }
    
    
    override func setup() {
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        dropShadow(color: .black,
                   opacity: 0.1,
                   offSet: .init(width: 0, height: 3.4),
                   radius: 3.4)
        
        subviewsPreparedAL {
            containerStackView
            editButton
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
        
        if preferencesManager.userType == .reseller {
            editButton.removeFromSuperview()
        }
        containerStackView.top(20).trailing(20).centerVertically().centerHorizontally()
        containerStackView.clipsToBounds = false
        containerStackView.layer.cornerRadius = 13
        imageView.width(100).height(100)
        editButton.top(20).trailing(15).width(20).height(20)
    }
    
}
