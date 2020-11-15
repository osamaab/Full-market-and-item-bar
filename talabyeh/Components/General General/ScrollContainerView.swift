//
//  ScrollContainerView.swift
//  talabyeh
//
//  Created by Hussein Work on 11/12/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

/**
 A simple components that provides scrolling behavior for it's content whenever possible, this helps us more with adaptive content where we need to scroll on smaller devices
 */
class ScrollContainerView: UIView {
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
        
        contentContainerView.widthAnchor.constraint(equalTo: scrollViewContainerView.widthAnchor).isActive = true
        let constraint = contentContainerView.heightAnchor.constraint(equalTo: scrollViewContainerView.heightAnchor)
        constraint.priority = .defaultLow
        constraint.isActive = true
    }
    
    fileprivate func setupContents(with containerView: UIView){
        containerView.addSubview(contentView)
        contentView.fillContainer()
        
        contentView.backgroundColor = .clear
        contentContainerView.backgroundColor = .clear
        scrollViewContainerView.backgroundColor = .clear
    }
}

