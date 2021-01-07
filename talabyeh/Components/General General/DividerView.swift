//
//  DividerView.swift
//  talabyeh
//
//  Created by Hussein Work on 11/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class DividerView: UIView {

    let axis: NSLayoutConstraint.Axis
    
    init(axis: NSLayoutConstraint.Axis = .horizontal){
        self.axis = axis
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        self.axis = .horizontal
        super.init(coder: coder)
        setup()
    }
    
    
    func setup() {
        backgroundColor = DefaultColorsProvider.decoratorBorder
    }
    
    override var intrinsicContentSize: CGSize {
        .init(width: axis == .horizontal ? Self.noIntrinsicMetric : 1, height: axis == .vertical ? Self.noIntrinsicMetric : 1)
    }
}
