//
//  CompanyInformationInputContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 15/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class CompanyInformationInputContentView: UIView {

    let stackView: UIStackView = .init()
    
    let labelView: LabelView = .init(title: "Company Profile", icon: nil)
    
    let titleView: TintedLabelCollectionReusableView = .init(verticalPadding: 12, horizontalPadding: 20)
    
    let scrollView: ScrollContainerView
    
    fileprivate var textViews: [String: TextView] = [:]
    
    init(inputFields: [String]) {
        scrollView = .init(contentView: stackView)
        super.init(frame: .zero)
        
        
        inputFields.forEach {
            textViews[$0] = self.textView(for: $0)
        }
        
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.fillContainer()
        
        
        stackView.axis(.vertical)
            .alignment(.fill)
            .distribution(.fill)
            .spacing(15)
            .preparedForAutolayout()
                
        titleView.title = "Create New"
        
        stackView.addingArrangedSubviews([labelView, titleView] + Array(textViews.values))
        textViews.values.forEach {
            $0.height(100)
        }
        
        scrollView.scrollView.contentInset.bottom += 50
    }
    
    fileprivate func textView(for title: String) -> TextView {
        let textView = TextView()
        textView.placeholder = title
        return textView
    }
}
