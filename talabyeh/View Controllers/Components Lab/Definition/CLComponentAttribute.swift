//
//  CLComponentAttribute.swift
//  talabyeh
//
//  Created by Hussein Work on 18/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

enum CLComponentRenderPosition {
    case preAdding
    case afterAdding
}

enum CLComponentAttribute {
    case customPositioning
    case height(CGFloat)
    case useClassName
    
    
    var renderPosition: CLComponentRenderPosition {
        switch self {
        case .customPositioning:
            return .preAdding
        case .height:
            return .afterAdding
        case .useClassName:
            return .afterAdding
        }
    }
    
    @discardableResult
    func render(for view: UIView) -> UIView {
        switch self {
        case .height(let height):
            view.height(height)
            return view
        case .customPositioning:
            let newContainerView = UIView()
            newContainerView.backgroundColor = .clear
            newContainerView.translatesAutoresizingMaskIntoConstraints = false
            
            newContainerView.addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.leading(0).top(0).centerVertically()
            
            
            return newContainerView
        case .useClassName:
            return view
        }
    }
}
