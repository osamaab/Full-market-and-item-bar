//
//  BaseOprationCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 11/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        contentView.subviewsPreparedAL {
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
        containerView.dropShadow(color: UIColor.black, opacity: 0.16, offSet: .init(width: 0, height: 0), radius: 6)
        
        self.apply(backgroundType: backgroundType, on: containerView)
    }
    
    fileprivate func apply(backgroundType: BackgroundType, on view: UIView){
        switch backgroundType {
        case .solid(let color):
            view.backgroundColor = color
        case .bordered(let color):
            view.backgroundColor = DefaultColorsProvider.background
            view.layer.borderColor = color.cgColor
            view.layer.borderWidth = 2
        case .none:
            view.backgroundColor = DefaultColorsProvider.background
        case .gradient(let first, let second):
            //Unsupported for now
            break
        }
    }
}


