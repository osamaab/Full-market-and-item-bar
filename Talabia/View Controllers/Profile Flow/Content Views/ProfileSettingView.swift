//
//  ProfileSettingView.swift
//  Talabia
//
//  Created by Osama Abu hdba on 02/05/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import UIKit
import Stevia

 class ProfileSettingView: BasicViewWithSetup {
    
    let LanguageButton = UIButton().then{
        $0.setTitle("Arabic", for: .normal)
        $0.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        $0.titleLabel?.font = .font(for: .regular, size: 17)
        $0.setImage(UIImage(named: "Lan_Setting"), for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DefaultColorsProvider.tintPrimary.cgColor;
        

        $0.layer.cornerRadius = 11
    }
    
    let LanguageButonView = UIView().then{
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DefaultColorsProvider.tintPrimary.cgColor;
        $0.layer.cornerRadius = 11
    }
    let label = UILabel().then{
        $0.text = "Arabic".localization
        $0.font = .font(for: .regular, size: 17)
        $0.textColor = DefaultColorsProvider.tintPrimary
    }
    let imageView = UIImageView().then{
        $0.image = UIImage(named: "Lan_Setting")
    }
    let ModeButton = UIButton().then{
        $0.setTitle("Design Mood", for: .normal)
        $0.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        $0.titleLabel?.font = .font(for: .regular, size: 17)
        $0.setImage(UIImage(named: "Mode_Setting"), for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DefaultColorsProvider.tintPrimary.cgColor;
        $0.titleEdgeInsets = .init(
            top: 0,
            left: -50,
            bottom: 0,
            right: 160)
        $0.imageEdgeInsets = .init(
            top: 0,
            left: -80,
            bottom: 0,
            right: 160)
        $0.layer.cornerRadius = 11
    }
    
    let containerStackView: UIStackView = .init()
    
    override func setup() {
        subviewsPreparedAL {
//            containerStackView
            LanguageButonView
        }
        
        containerStackView
            .alignment(.center)
            .distribution(.fill)
            .spacing(8)
            .axis(.vertical)
        
//        containerStackView.addingArrangedSubviews {
//            LanguageButonView
//        }
        LanguageButonView.subviewsPreparedAL{
            label
            imageView
        }
        containerStackView.leading(16).trailing(16).bottom(0).top(0)
        containerStackView.clipsToBounds = false
        containerStackView.height(108)
//        LanguageButton.top(0).trailing(0).bottom(0).leading(0)
//        LanguageButton.height(50)
        ModeButton.top(0).trailing(0).bottom(0).leading(0)
        ModeButton.height(50)
        
        LanguageButonView.Width == view.Width
        LanguageButonView.height(50)
        imageView.leading(25).top(10)
        label.Leading == imageView.Trailing + 10
        label.centerVertically()
        
        LanguageButton.titleEdgeInsets = .init(
            top: 0,
            left: -60,
            bottom: 0,
            right: 160)
        LanguageButton.imageEdgeInsets = .init(
            top: -5,
            left: -90,
            bottom: 0,
            right: 160)
    }
}
