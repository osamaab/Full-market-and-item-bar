//
//  CLComponentPreviewContext.swift
//  talabyeh
//
//  Created by Hussein Work on 24/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

protocol CLComponentPreviewContext {
    
    
    init(componentPreview: CLComponentPreview.Type)
    
    /**
     The original container view for clients to render on.
     */
    var containerView: UIView { get }
    
    /**
     Tells the receiver to render itself into a ready view controller
     */
    func render() -> UIViewController
}

class CLDefaultCardComponentContext: CLComponentPreviewContext {
    
    var componentPreview: CLComponentPreview.Type
    
    required init(componentPreview: CLComponentPreview.Type) {
        self.componentPreview = componentPreview
        
        self.containerView = .init()
        self.containerView.backgroundColor = DefaultColorsProvider.background
    }
    
    var containerView: UIView
    
    func render() -> UIViewController {
        // make sure to render the component in the client
        self.componentPreview.render(in: self)
        
        return CLDefaultPreviewViewController(contentView: self.containerView, title: componentPreview.name)
    }
}
