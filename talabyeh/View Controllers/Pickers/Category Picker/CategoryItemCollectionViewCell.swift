//
//  CategoryItemCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 20/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CategoryItemCollectionViewCell: UICollectionViewCell {
    
    let containerView: UIView = .init()
    let titleLabel: UILabel = .init()
    let imageView: UIImageView = .init()
    let checkboxView: CheckboxView = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        self.contentView.clipsToBounds = false
        self.clipsToBounds = false
        self.containerView.clipsToBounds = false
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        checkboxView.translatesAutoresizingMaskIntoConstraints = false

        
        contentView.subviews {
            containerView
            titleLabel
        }
        
        containerView.subviews {
            imageView
            checkboxView
        }
        
        containerView.layer.cornerRadius = 12
        containerView.backgroundColor = DefaultColorsProvider.itemBackground
        containerView.dropShadow(color: .black,
                                 opacity: 0.16,
                                 offSet: .init(width: 0, height: 2),
                                 radius: 2,
                                 scale: true)
        
        imageView.contentMode = .scaleAspectFit
        
        
        imageView.leading(30).centerHorizontally().top(20).centerVertically()
        checkboxView.top(8).trailing(8).width(20).height(20)
        
        titleLabel.textAlignment = .center
        titleLabel.font = .font(for: .semiBold, size: 12)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        containerView.top(0).leading(0).trailing(0)
        titleLabel.bottom(0).leading(15).trailing(15)
        
        containerView.Bottom == titleLabel.Top - 15

        imageView.image = UIImage(named: "sample_category")
        titleLabel.text = "Accessories"
        checkboxView.isSelected = true
    }
}
