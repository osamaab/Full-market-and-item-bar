//
//  BaseOprationCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 11/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia


/**
 The default operation collectionview cell provides a base methods for subclasse to implement, like the border, background, and the container stack.
 
 Subviews (must) use the containerStackView property when adding any sub-components to the view.
 */
class BaseOprationCollectionViewCell: UICollectionViewCell {
    
    enum BackgroundType {
        case none
        case solid(UIColor)
        case gradient(UIColor, UIColor)
        case bordered(UIColor)
    }
    
    let containerView: UIView = .init()
    let containerStackView: UIStackView = .init()
    
    
    var backgroundType: BackgroundType {
        .none
    }
    
    /**
     Intro: the operation cell sometimes used in other places ( like the operation details screen ), in this case, we need a way to know where to inject any additional views, custom subclasses uses this index to mark a beginning for custom content
     */
    var indexForInjectingContent: Int {
        0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        subviewsPreparedAL {
            containerView
        }
        
        containerView.subviewsPreparedAL {
            containerStackView
        }

        containerStackView.alignment(.fill)
            .distribution(.fill)
            .spacing(8)
            .axis(.vertical)
        
        
        containerStackView.fillContainer(padding: 15)
        
        containerView.fillContainer()
        containerView.layer.cornerRadius = 10
        containerView.dropShadow(color: DefaultColorsProvider.decoratorShadow,
                                 opacity: 0.16,
                                 offSet: .init(width: 0, height: 0),
                                 radius: 6)
        
        self.apply(backgroundType: backgroundType, on: containerView)
    }
    
    fileprivate func apply(backgroundType: BackgroundType, on view: UIView){
        switch backgroundType {
        case .solid(let color):
            view.backgroundColor = color
        case .bordered(let color):
            view.backgroundColor = DefaultColorsProvider.backgroundPrimary
            view.layer.borderColor = color.cgColor
            view.layer.borderWidth = 2
        case .none:
            view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        case .gradient(let first, let second):
            //Unsupported for now
            break
        }
    }
}


