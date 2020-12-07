//
//  CardContainerView.swift
//  talabyeh
//
//  Created by Hussein Work on 02/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

/**
 The actual container card
 */
class CardContainerView: UIView {
    
    let titleLabel: UILabel
    let contentView: UIView
    
    var title: String? {
        didSet {
            titleLabel.text = title
            
            if title == nil || (title ?? "").isEmpty {
                titleLabel.isHidden = true
            }
        }
    }
    
    fileprivate var containerStack: UIStackView = .init()
    
    init(title: String?, contentView: UIView){
        self.contentView = contentView
        self.titleLabel = .init()
        self.titleLabel.text = title
        super.init(frame: .zero)
        
        self.title = title
        if title == nil || (title ?? "").isEmpty {
            titleLabel.isHidden = true
        }
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup(){
        backgroundColor = DefaultColorsProvider.background
        layer.cornerRadius = 20
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // this prevents the title label from being streached.
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.setContentHuggingPriority(.init(240), for: .vertical)
        
        dropShadow(color: UIColor.blue.withAlphaComponent(0.16),
                   opacity: 0.5,
                   offSet: .init(width: 0, height: 3),
                   radius: 4)
        
        titleLabel.textColor = DefaultColorsProvider.text
        titleLabel.font = .font(for: .bold, size: 21)
        
        
        subviews {
            containerStack
        }
        
        containerStack.addingArrangedSubviews {
            titleLabel
            contentView
        }
        
        containerStack
            .axis(.vertical)
            .distribution(.fill)
            .alignment(.fill)
            .spacing(20)
            .preparedForAutolayout()
        
        
        // constraints part :))
        containerStack.top(25).bottom(25).left(20).right(20)
    }
}
