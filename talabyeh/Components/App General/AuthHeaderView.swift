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
    
    enum Element {
        case title(String)
        case type(UserType)
        case subtitle(String)
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
        fatalError()
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
        containerStackView.alignment(.fill).distribution(.fill).axis(.vertical).spacing(15)
        
        titleLabel.font = .font(for: .bold, size: 22)
        titleLabel.textColor = DefaultColorsProvider.tintPrimary
        
        typeBackgroundView.backgroundColor = DefaultColorsProvider.tintSecondary
        typeBackgroundView.height(26)
        typeBackgroundView.layer.cornerRadius = 13
        typeBackgroundView.clipsToBounds = true
        typeBackgroundView.fillContainer()
        
        typeImageView.contentMode = .scaleAspectFit
        typeImageView.height(35).width(33).leading(15).centerVertically()
        
        typeTitleLabel.font = .font(for: .semiBold, size: 17)
        typeTitleLabel.textColor = DefaultColorsProvider.tintPrimary
        typeTitleLabel.centerVertically().trailing(15)
        
        typeTitleLabel.Leading == typeImageView.Trailing + 15
        
        subtitleLabel.font = .font(for: .regular, size: 16)
        subtitleLabel.textColor = DefaultColorsProvider.tintPrimary
        subtitleLabel.numberOfLines = 0
        
        
        containerStackView.spacing(3)
        [titleLabel, typeContainerView, subtitleLabel].forEach { $0.isHidden = true }
        elements.forEach {
            switch $0 {
            case .title(let title):
                titleLabel.isHidden = false
                titleLabel.text = title
                break
            case .type(let authType):
                typeContainerView.isHidden = false
                containerStackView.spacing(15)
                
                typeTitleLabel.text = authType.title
                typeImageView.image = authType.image
                
                typeBackgroundView.layer.cornerRadius = 13
                break
            case .subtitle(let subtitle):
                subtitleLabel.isHidden = false
                subtitleLabel.text = subtitle
                break
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        typeBackgroundView.layer.cornerRadius = typeBackgroundView.bounds.height / 2
    }
}
