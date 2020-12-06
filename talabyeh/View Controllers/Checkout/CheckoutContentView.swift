//
//  CheckoutContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 02/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class CheckoutContentView: UIView {

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
        
        containerStackView
            .axis(.vertical)
            .alignment(.fill)
            .distribution(.fill)
            .spacing(15)
        
        // constraints part :))
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollContainerView.translatesAutoresizingMaskIntoConstraints = false
        
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
