//
//  HorizontalScrollContainerView.swift
//  talabyeh
//
//  Created by Hussein Work on 10/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

//TODO: Implement Me
class HorizontalScrollContainerView: UIView {
    /**
     The view containing the scroll view
     */
    let scrollViewContainerView: UIView = UIView()
    
    
    /**
     The actual scroll view
     */
    let scrollView: UIScrollView = UIScrollView()
    
    /**
     The content container, inside the sroll view
     */
    let contentContainerView: UIView = UIView()
    
    /**
     The content view itself :)
     */
    let contentView: UIView
    
    init(contentView: UIView){
        self.contentView = contentView
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    fileprivate func setup(){
        addViews()
        addConstraints()
        setupContents(with: contentContainerView)
    }
    
    fileprivate func addViews(){
        addSubview(scrollViewContainerView)
        scrollViewContainerView.addSubview(scrollView)
        scrollView.addSubview(contentContainerView)
    }
    
    fileprivate func addConstraints(){
        contentContainerView.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContainerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollViewContainerView.fillContainer()
        scrollView.fillContainer()
        contentContainerView.fillContainer()
        
        contentContainerView.heightAnchor.constraint(equalTo: scrollViewContainerView.heightAnchor).isActive = true
        let constraint = contentContainerView.widthAnchor.constraint(equalTo: scrollViewContainerView.widthAnchor)
        constraint.priority = .defaultLow
        constraint.isActive = true
    }
    
    fileprivate func setupContents(with containerView: UIView){
        containerView.addSubview(contentView)
        contentView.top(0).leading(0).bottom(0).trailing(>=0)
        
        contentView.backgroundColor = .clear
        contentContainerView.backgroundColor = .clear
        scrollViewContainerView.backgroundColor = .clear
    }
}
