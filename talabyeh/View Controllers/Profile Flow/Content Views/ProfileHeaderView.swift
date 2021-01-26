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
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let tertiaryLabel = UILabel()
    
    
    override func setup() {
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = DefaultColorsProvider.backgroundPrimary
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        
        titleLabel.font = .font(for: .semiBold, size: 22)
        subtitleLabel.font = .font(for: .semiBold, size: 16)
        tertiaryLabel.font = .font(for: .regular, size: 13)
        
        titleLabel.textColor = DefaultColorsProvider.textPrimary1
        subtitleLabel.textColor = DefaultColorsProvider.textSecondary1
        tertiaryLabel.textColor = DefaultColorsProvider.textSecondary1
        
        
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        dropShadow(color: .lightGray,
                   opacity: 0.16,
                   offSet: .init(width: 0, height: 3.4),
                   radius: 3.4)
        
        subviewsPreparedAL {
            containerStackView
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
    }
}
