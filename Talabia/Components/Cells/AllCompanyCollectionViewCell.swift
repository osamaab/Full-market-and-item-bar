//
//  AllCompanyCollectionViewCell.swift
//  Talabia
//
//  Created by Osama Abu hdba on 15/04/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class AllCompanyCollectionViewCell: UICollectionViewCell {
    
    let containerView: UIView = .init()
    let titleLabel: UILabel = .init()
    let imageView: UIImageView = .init()
    let checkboxView: FavoriteButton = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.checkboxView.isChecked = false
        
    }
    
    func setup(){
        self.contentView.clipsToBounds = false
        self.clipsToBounds = false
        self.containerView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFit

        
        contentView.subviewsPreparedAL {
            containerView
            titleLabel
        }
        
        containerView.subviewsPreparedAL {
            imageView
            checkboxView
        }

        containerView.backgroundColor = DefaultColorsProvider.backgroundPrimary
        containerView.dropShadow(color: DefaultColorsProvider.decoratorShadow,
                                 opacity: 0.3,
                                 offSet: .init(width: 0, height: 2),
                                 radius: 2)
        
        imageView.contentMode = .scaleAspectFit
        
        
        imageView.centerVertically().centerHorizontally()
        imageView.width(100%)
        imageView.height(70%)
        checkboxView.top(3).trailing(3).width(40).height(40)
        
        titleLabel.textAlignment = .center
        titleLabel.font = .font(for: .regular, size: 15)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.clipsToBounds = false
        
        containerView.top(0).leading(0).trailing(0).bottom(0)
        titleLabel.Top == containerView.Bottom + 5
        titleLabel.leading(0).trailing(0)
        containerView.Bottom == titleLabel.Top - 15
    }
}
