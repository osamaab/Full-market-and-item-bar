//
//  NewDistributerContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 15/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

/**
 See: Page 80 of the design
 
 The view acts as a sections container, each section represents a card to display.
 */
class NewDistributerContentView: UIView {
    
    lazy var titleLabel: UILabel = .init()
    lazy var containerStackView: UIStackView = .init()
    lazy var scrollContainerView: ScrollContainerView = .init(contentView: containerStackView)
    
    fileprivate var cardViews: [NDCardContainerView] = []
    
    init(){
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    fileprivate func setup(){
        backgroundColor = DefaultColorsProvider.background1
        
        titleLabel.textColor = DefaultColorsProvider.text
        titleLabel.font = .font(for: .bold, size: 21)
        
        containerStackView
            .axis(.vertical)
            .alignment(.fill)
            .distribution(.fill)
            .spacing(15)
        
        containerStackView.addingArrangedSubviews {
            titleLabel
        }
        
        // constraints part :))
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollContainerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(scrollContainerView)        
        scrollContainerView.fillContainer(padding: 20)
    }
    
    @discardableResult
    func insertCardView(with contentView: UIView, title: String) -> NDCardContainerView {
        let newCardView = NDCardContainerView(title: title, contentView: contentView)
        
        cardViews.append(newCardView)
        containerStackView.addArrangedSubview(newCardView)
        
        return newCardView
    }
}

/**
 The actual container card
 */
class NDCardContainerView: UIView {
    
    let titleLabel: UILabel
    let contentView: UIView
    
    fileprivate var containerStack: UIStackView = .init()
    
    init(title: String, contentView: UIView){
        self.contentView = contentView
        self.titleLabel = .init()
        self.titleLabel.text = title
        super.init(frame: .zero)
        
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
                   radius: 4,
                   scale: true)
        
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


