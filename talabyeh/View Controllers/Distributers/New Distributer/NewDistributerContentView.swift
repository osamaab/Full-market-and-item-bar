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
    
    fileprivate var cardViews: [CardContainerView] = []
    
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
    func insertCardView<ContentView: UIView>(with contentView: ContentView, title: String) -> CardContainerView {
        let newCardView = CardContainerView(title: title, contentView: contentView)
        
        cardViews.append(newCardView)
        containerStackView.addArrangedSubview(newCardView)
        
        return newCardView
    }
}



