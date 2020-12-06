//
//  FieldView.swift
//  talabyeh
//
//  Created by Hussein Work on 02/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

/**
 A Field view is basicly a view who has a title label alongside it's content view,
 */
class FieldView<ContentView: UIView>: UIView {
    
    let contentView: ContentView
    let titleLabel: UILabel
    let stackView: UIStackView
    
    /**
     Vertical or horizontal?
     */
    var axis: NSLayoutConstraint.Axis = .horizontal {
        didSet {
            stackView.axis = axis
        }
    }
    
    /**
     The title for the field, null means the titleLabel is hidden
     */
    var title: String? {
        didSet {
            titleLabel.isHidden = title == nil
            titleLabel.text = title
        }
    }
    
    var spacing: CGFloat = 8 {
        didSet {
            stackView.spacing = spacing
        }
    }
    
    init(contentView: ContentView, title: String?){
        self.contentView = contentView
        self.title = title
        
        self.stackView = .init()
        self.titleLabel = .init()
        super.init(frame: .zero)
        setup()
    }
    
    convenience init(contentView: ContentView){
        self.init(contentView: contentView, title: nil)
    }
    
    convenience init(title: String?){
        self.init(contentView: .init(), title: title)
    }
    
    convenience init(){
        self.init(contentView: .init(), title: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup(){
        titleLabel.text = title
        titleLabel.isHidden = title == nil
        titleLabel.font = .font(for: .medium, size: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contentView)
        
        stackView.alignment(.fill)
            .axis(self.axis)
            .spacing(self.spacing)
            .preparedForAutolayout()
        
        stackView.addingArrangedSubviews {
            titleLabel
            contentView
        }
        
        stackView.fillContainer()
    }
}
