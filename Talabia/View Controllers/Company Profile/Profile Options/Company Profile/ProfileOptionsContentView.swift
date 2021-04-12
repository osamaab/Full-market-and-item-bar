//
//  ProfileOptionsContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 15/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class ProfileOptionsContentView: UIView {
    
    let labelView: LabelView = .init(title: "Company Profile", icon: UIImage(named: ""))
    
    var sectionViews: [TintedLabelCollectionReusableView] = []
    
    let stackView: UIStackView = .init()
    
    let scrollView: ScrollContainerView
    
    init(options: [String]){
        self.sectionViews = options.map {
            let header = TintedLabelCollectionReusableView(verticalPadding: 12, horizontalPadding: 20)
            header.title = $0
            return header
        }
        
        scrollView = .init(contentView: stackView)
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.fillContainer()
        
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        stackView.axis(.vertical)
            .alignment(.fill)
            .distribution(.fill)
            .spacing(15)
            .preparedForAutolayout()
        
        stackView.addingArrangedSubviews([labelView] + sectionViews)
    }
}
