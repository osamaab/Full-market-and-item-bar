//
//  TintedLabelCollectionViewSectionHeader.swift
//  talabyeh
//
//  Created by Hussein Work on 15/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class TintedLabelCollectionReusableView: UICollectionReusableView {
    
    let titleLabel: UILabel = .init()
    
    let verticalPadding: CGFloat
    let horizontalPadding: CGFloat
    
    var title: String? {
        set {
            titleLabel.text = newValue
        } get {
            titleLabel.text
        }
    }
    
    override init(frame: CGRect) {
        self.verticalPadding = 8
        self.horizontalPadding = 15
        super.init(frame: frame)
        setup()
    }
    
    init(verticalPadding: CGFloat = 5, horizontalPadding: CGFloat = 15){
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup(){
        layer.cornerRadius = 10
        backgroundColor = DefaultColorsProvider.tintSecondary
        
        addSubview(titleLabel)
        
        titleLabel.font = .font(for: .bold, size: 16)
        titleLabel.textColor = DefaultColorsProvider.tintPrimary
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    /**
     Subviews can override this method to provide custom layout setup
     */
    func setupConstraints(){
        titleLabel.fillVertically(padding: verticalPadding)
        titleLabel.fillHorizontally(padding: horizontalPadding)
    }
}
