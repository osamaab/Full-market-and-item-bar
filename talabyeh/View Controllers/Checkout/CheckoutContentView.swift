//
//  CheckoutContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 02/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia


class CheckoutContentView: UIView {

    lazy var containerStackView: UIStackView = .init()
    lazy var footerView: CheckoutFooterView = .init()
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
        footerView.translatesAutoresizingMaskIntoConstraints = false

        footerView.height(50)
        
        addSubview(scrollContainerView)
        scrollContainerView.fillContainer(padding: 20)
        
        containerStackView.addArrangedSubview(footerView)
    }
    
    @discardableResult
    func insertCardView<ContentView: UIView>(with contentView: ContentView, title: String?) -> CardContainerView {
        let newCardView = CardContainerView(title: title, contentView: contentView)
        
        cardViews.append(newCardView)
        containerStackView.insertArrangedSubview(newCardView, at: cardViews.count - 1)
        
        
        return newCardView
    }
}

class CheckoutFooterView: BasicViewWithSetup {
    
    let requestButton: ActionButton = .init()
    let cancelButton: UIButton = .init()
    
    override func setup() {
        backgroundColor = .clear
        
        requestButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        
        subviewsPreparedAL {
            cancelButton
            requestButton
        }
        
        requestButton.top(0).bottom(0).trailing(0).width(60%)
        cancelButton.top(0).bottom(0).leading(0).width(35%)
        
        requestButton.backgroundColor = DefaultColorsProvider.darkerTint
        requestButton.setTitle("Request", for: .normal)
        requestButton.setTitleColor(DefaultColorsProvider.background, for: .normal)
        
        cancelButton.backgroundColor = DefaultColorsProvider.background
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(DefaultColorsProvider.darkerTint, for: .normal)
    }
}
