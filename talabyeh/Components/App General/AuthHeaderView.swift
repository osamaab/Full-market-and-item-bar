//
//  AuthHeaderView.swift
//  talabyeh
//
//  Created by Hussein Work on 20/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class AuthHeaderView: UIView {
    
    enum Element: String, CaseIterable {
        case title
        case type
        case subtitle
    }
    
    let titleLabel = UILabel()
    let typeContainerView: UIView = .init()
    let subtitleLabel = UILabel()
    
    let typeBackgroundView: UIView = .init()
    let typeTitleLabel: UILabel = .init()
    let typeImageView: UIImageView = .init()
    
    let containerStackView: UIStackView = .init()
    
    let elements: [Element]

    init(elements: [Element]) {
        self.elements = elements
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        self.elements = Element.allCases
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        typeContainerView.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        typeBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        typeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        typeImageView.translatesAutoresizingMaskIntoConstraints = false

        
        addSubview(containerStackView)
        
        containerStackView.arrangedSubviews {
            titleLabel
            typeContainerView
            subtitleLabel
        }
        
        typeContainerView.subviews {
            typeBackgroundView
            typeImageView
            typeTitleLabel
        }
        
        containerStackView.fillContainer()
        containerStackView.alignment(.fill).distribution(.fill).axis(.vertical).spacing(10)
        
        titleLabel.font = .font(for: .bold, size: 22)
        titleLabel.textColor = DefaultColorsProvider.darkerTint
        
        typeBackgroundView.backgroundColor = DefaultColorsProvider.lightTint
        typeBackgroundView.layer.cornerRadius = 26 / 2
        typeBackgroundView.height(26)
        typeBackgroundView.fillContainer()
        
        typeImageView.contentMode = .scaleAspectFit
        typeImageView.height(30).width(30).leading(15).centerVertically()
        
        typeTitleLabel.font = .font(for: .semiBold, size: 17)
        typeTitleLabel.textColor = DefaultColorsProvider.darkerTint
        typeTitleLabel.centerVertically().trailing(15)
        
        typeTitleLabel.Leading == typeImageView.Trailing + 15
        
        subtitleLabel.font = .font(for: .regular, size: 16)
        subtitleLabel.textColor = DefaultColorsProvider.darkerTint
        subtitleLabel.numberOfLines = 0
        
        
        [titleLabel, typeContainerView, subtitleLabel].forEach { $0.isHidden = true }
        elements.forEach {
            switch $0 {
            case .title:
                titleLabel.isHidden = false
                break
            case .type:
                typeContainerView.isHidden = false
                break
            case .subtitle:
                subtitleLabel.isHidden = false
                break
            }
        }
        
        titleLabel.text = "Welcome to TALABYEH"
        typeTitleLabel.text = "Company"
        typeImageView.image = UIImage(named: "auth_company")
        subtitleLabel.text = "Please choose the category of resellers You can serve"
    }
}
