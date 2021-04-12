//
//  VerticalPaddingView.swift
//  talabyeh
//
//  Created by Hussein Work on 24/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

/**
 A view in which centers it's content, with specified vertical padding ( top bottom ), while letting the content freely take space on horizontal axis ( but doesn't touch the edges )
 */
class VerticalPaddingView: UIView {
    
    let contentView: UIView
    let bottomPadding: CGFloat
    let topPadding: CGFloat
    
    init(contentView: UIView, verticalPadding: CGFloat){
        self.contentView = contentView
        self.topPadding = verticalPadding
        self.bottomPadding = verticalPadding
        super.init(frame: .zero)
        setup()
        
    }
    
    init(contentView: UIView, topPadding: CGFloat, bottomPadding: CGFloat){
        self.contentView = contentView
        self.topPadding = topPadding
        self.bottomPadding = bottomPadding
        super.init(frame: .zero)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentView)
        contentView.centerHorizontally()
        contentView.top(topPadding).bottom(bottomPadding)
        contentView.Leading >= self.Leading
    }
}

extension UIView {
    func embededInVerticalPaddingView(topPadding: CGFloat = 0, bottomPadding: CGFloat = 0) -> VerticalPaddingView {
        return .init(contentView: self, topPadding: topPadding, bottomPadding: bottomPadding)
    }
}
