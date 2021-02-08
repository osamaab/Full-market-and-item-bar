//
//  NewCompanyBranchContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 08/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class NewCompanyBranchContentView: UIView {

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
        backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        titleLabel.textColor = DefaultColorsProvider.textPrimary1
        titleLabel.font = .font(for: .bold, size: 21)
        titleLabel.isHidden = true
        
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
