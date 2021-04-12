//
//  CategoryCollectionReusableView.swift
//  talabyeh
//
//  Created by Hussein Work on 20/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CategoryCollectionReusableView: UICollectionReusableView {
        
    
    let stackView: UIStackView = .init()
    
    let imageView: UIImageView = .init()
    let separatorView: DividerView = .init(axis: .vertical)
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
        backgroundColor = DefaultColorsProvider.containerBackground3
        layer.cornerRadius = 10
        
        titleLabel.font = .font(for: .bold, size: 17)
        titleLabel.textColor = DefaultColorsProvider.tintPrimary

        separatorView.backgroundColor = DefaultColorsProvider.tintPrimary
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = DefaultColorsProvider.tintPrimary

        subviewsPreparedAL {
            stackView
        }
        
        stackView.axis(.horizontal)
            .spacing(15)
            .distribution(.fill)
            .alignment(.center)

        stackView.addingArrangedSubviews {
            imageView
            separatorView
            titleLabel
        }
        
        stackView.fillVertically(padding: 10).leading(20).trailing(>=20)
        imageView.width(35).height(35)
        separatorView.Height == stackView.Height
    }
}

extension CategoryCollectionReusableView: CLComponentPreview {
    static var groupIdentifier: CLComponentGroupIdentifier {
        .headersAndFooters
    }
    
    static func render(in context: CLComponentPreviewContext) {
        let containerView = context.containerView
        let view = CategoryCollectionReusableView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "Cateory 1"
        view.imageView.image = UIImage(named: "next-selected")
        
        containerView.addSubview(view)
        view.fillContainer(padding: 0)
    }
}
