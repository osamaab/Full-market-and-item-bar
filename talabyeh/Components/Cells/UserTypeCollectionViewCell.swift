//
//  UserTypeCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 07/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class UserTypeCollectionViewCell: UICollectionViewCell {
    
    let containerStackView: UIStackView = .init()
    let imageView: UIImageView = .init()
    let dividerView: DividerView = .init(axis: .vertical)
    let titleLabel: UILabel = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        layer.cornerRadius = 20
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFit
        titleLabel.font = .font(for: .semiBold, size: 16)
        titleLabel.textColor = DefaultColorsProvider.tintPrimary
        
        dividerView.backgroundColor = DefaultColorsProvider.tintPrimary
        dividerView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        containerStackView.axis(.horizontal)
            .spacing(15)
            .alignment(.center)
            .distribution(.fill)
            .preparedForAutolayout()
        
        addSubview(containerStackView)
        containerStackView.fillHorizontally(padding: 20)
        containerStackView.fillVertically(padding: 20)
        
        containerStackView.addingArrangedSubviews {
            imageView
            dividerView
            titleLabel
        }
        
        dividerView.height(100%)
        imageView.width(30).height(30)
        
        setSelected(false, animated: false)
    }
    
    func setSelected(_ selected: Bool, animated: Bool){
        let block = {
            self.backgroundColor = selected ? DefaultColorsProvider.tintSecondary : DefaultColorsProvider.containerBackground2
        }
        
        if animated {
            UIView.animate(withDuration: 0.3, animations: block)
        } else {
            block()
        }
    }
}
