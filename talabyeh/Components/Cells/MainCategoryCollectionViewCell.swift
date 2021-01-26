//
//  CategoryItemCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 20/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class MainCategoryCollectionViewCell: UICollectionViewCell {
    
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

        
        contentView.subviewsPreparedAL {
            containerView
            titleLabel
        }
        
        containerView.subviewsPreparedAL {
            imageView
            checkboxView
        }
        
        containerView.layer.cornerRadius = 12
        containerView.backgroundColor = DefaultColorsProvider.containerBackground3
        containerView.dropShadow(color: DefaultColorsProvider.decoratorShadow,
                                 opacity: 0.16,
                                 offSet: .init(width: 0, height: 2),
                                 radius: 2)
        
        imageView.contentMode = .scaleAspectFit
        
        
        imageView.leading(30).centerHorizontally().top(20).centerVertically()
        checkboxView.top(8).trailing(8).width(20).height(20)
        
        titleLabel.textAlignment = .center
        titleLabel.font = .font(for: .semiBold, size: 12)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        containerView.top(0).leading(0).trailing(0)
        titleLabel.bottom(0).leading(15).trailing(15)
        containerView.Bottom == titleLabel.Top - 15
    }
}


extension MainCategoryCollectionViewCell: CLComponentPreview {
    static var groupIdentifier: CLComponentGroupIdentifier {
        .cells
    }
    
    static func render(in context: CLComponentPreviewContext) {
        let view: Self = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        context.containerView.addSubview(view)
        
        view.imageView.image = UIImage(named: "sample_category")
        view.titleLabel.text = "Accessories"
        view.isSelected = true
        
        view.top(20).bottom(20)
        view.leading(20)
        view.centerHorizontally()
    }
}
