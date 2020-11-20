//
//  AdvancedSearchItemCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 19/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class AdvancedSearchItemCollectionViewCell<T: UITextField>: UICollectionViewCell {
    
    fileprivate(set) var textField: T = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        layer.cornerRadius = 12
        layer.borderWidth = 0.5
        layer.borderColor = DefaultColorsProvider.fieldBorder.cgColor
        
        reloadContentView()
    }
    
    func reloadContentView(){
        contentView.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.fillContainer(padding: 0)
    }
}
