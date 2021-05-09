//
//  ProfileMenuItemCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 25/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class ProfileMenuItemCollectionViewCell: UICollectionViewCell {

    var imageView: UIImageView = .init()
    let titleLabel: UILabel = .init()
    let arrowImageView: ArrowImageView = .init()
    let worningImageView: UIImageView = .init()
    
    var style: ProfileMenuItem.Style = .normal {
        didSet {
            self.backgroundColor = style == .normal ? .white : DefaultColorsProvider.tintSecondary
            
                titleLabel.font = style == .normal ?
                .font(for: .regular, size: 17) :
                .font(for: .bold, size: 17)
                
            arrowImageView.image = style == .normal ?
               UIImage(named: "right-arrow"):
               UIImage(named: "see_more")
            
            if style == .imageChanged {
                imageView = style == .imageChanged ?
                    imageView.top(6) : imageView.top(8)
            }

        }
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
        backgroundColor = DefaultColorsProvider.backgroundPrimary
               
        imageView.tintColor = DefaultColorsProvider.tintPrimary
        imageView.contentMode = .center
        
        titleLabel.font = .font(for: .regular, size: 17)
        titleLabel.textColor = DefaultColorsProvider.tintPrimary

        subviewsPreparedAL {
            imageView
            titleLabel
            arrowImageView
            worningImageView
        }
        
        
        titleLabel.centerVertically()
        imageView.leading(20).height(25).width(25).centerVertically()
        titleLabel.Leading == imageView.Trailing + 15
        arrowImageView.trailing(20).height(12).width(12).centerVertically()
        worningImageView.image = UIImage(named: "operation-faild")
        worningImageView.isHidden = false
        worningImageView.clipsToBounds = true
        worningImageView.width(17).height(17).centerVertically()
        worningImageView.Trailing == arrowImageView.Leading - 10

        style = .normal
    }
}
