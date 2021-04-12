//
//  LoadingStateView.swift
//  talabyeh
//
//  Created by Hussein Work on 03/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoadingStateView: UIView {
        
    let activityIndicatorView: NVActivityIndicatorView = .init(frame: .zero, type: .ballBeat, color: DefaultColorsProvider.tintPrimary, padding: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    fileprivate func setup(){
        self.backgroundColor = .clear//DefaultColorsProvider.backgroundPrimary
        
        subviewsPreparedAL { () -> [UIView] in
            activityIndicatorView
        }
        
        activityIndicatorView.width(35).height(35)
        activityIndicatorView.centerInContainer()
        activityIndicatorView.startAnimating()
    }
}

extension LoadingStateView: CLComponentPreview {
    static var groupIdentifier: CLComponentGroupIdentifier {
        .general
    }
    
    static func render(in context: CLComponentPreviewContext) {
        let view: Self = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        context.containerView.addSubview(view)
        
        view.top(20).bottom(20)
        view.leading(35)
        view.centerHorizontally()
    }
}
