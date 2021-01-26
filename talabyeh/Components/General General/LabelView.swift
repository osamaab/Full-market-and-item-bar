//
//  LabelView.swift
//  talabyeh
//
//  Created by Hussein Work on 14/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

/**
 A view that provides a label with an image view in a stack
 */
class LabelView: UIView {
    
    let imageView: UIImageView = .init()
    
    /**
     The default image view
     */
    let titleLabel: UILabel = .init()
    
    /**
     The container stack for the label and image
     */
    let stackView: UIStackView = .init()
    
    
    var title: String? {
        didSet {
            titleLabel.isHidden = title == nil
            titleLabel.text = title
        }
    }
    
    var icon: UIImage? {
        didSet {
            self.imageView.isHidden = icon == nil
            self.imageView.image = icon
        }
    }
    
    init(title: String?, icon: UIImage?){
        super.init(frame: .zero)
        self.title = title
        self.icon = icon
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    fileprivate func setup(){
        addSubview(stackView)
        
        titleLabel.isHidden = title == nil
        titleLabel.text = title

        imageView.isHidden = icon == nil
        imageView.image = icon

        
        // default attributes :)
        imageView.tintColor = DefaultColorsProvider.tintPrimary
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.textColor = DefaultColorsProvider.tintPrimary
        titleLabel.font = .font(for: .bold, size: 16)
        
        stackView.fillContainer()
        stackView.axis(.horizontal)
            .alignment(.fill)
            .spacing(8)
            .preparedForAutolayout()
        
        stackView.addingArrangedSubviews {
            imageView
            titleLabel
        }
        
        imageView.width(20).height(25)
    }
}
