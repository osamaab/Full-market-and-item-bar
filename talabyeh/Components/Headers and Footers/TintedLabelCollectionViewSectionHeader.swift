//
//  TintedLabelCollectionViewSectionHeader.swift
//  talabyeh
//
//  Created by Hussein Work on 15/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class TintedLabelCollectionViewSectionHeader: UICollectionReusableView {
    
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
        self.verticalPadding = 5
        self.horizontalPadding = 8
        super.init(frame: frame)
        setup()
    }
    
    init(verticalPadding: CGFloat = 5, horizontalPadding: CGFloat = 8){
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
        backgroundColor = DefaultColorsProvider.lightTint
        
        addSubview(titleLabel)
        
        titleLabel.font = .font(for: .bold, size: 16)
        titleLabel.textColor = DefaultColorsProvider.darkerTint
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.fillVertically(padding: verticalPadding)
        titleLabel.fillHorizontally(padding: horizontalPadding)
    }
}
