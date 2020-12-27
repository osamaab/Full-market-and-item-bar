//
//  RoundedFillButton.swift
//  talabyeh
//
//  Created by Hussein Work on 15/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class RoundedFillButton: RoundedButton {
    
    override func setup() {
        super.setup()
        
        layer.borderColor = DefaultColorsProvider.tintPrimary.cgColor
        layer.borderWidth = 1
        
        backgroundColor = DefaultColorsProvider.tintSecondary
        setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        titleLabel?.font = .font(for: .medium, size: 16)
    }
}


extension RoundedFillButton: CLComponentPreview {
    
    static var groupIdentifier: CLComponentGroupIdentifier {
        .buttons
    }
    
    static func render(in context: CLComponentPreviewContext) {
        let newButton = self.init()
        newButton.contentEdgeInsets = .init(top: 10, left: 25, bottom: 10, right: 25)
        newButton.setTitle("Tap Meeee", for: .normal)
                
        context.containerView.subviewsPreparedAL { () -> [UIView] in
            newButton
        }
        
        newButton.centerHorizontally()
        newButton.top(20).bottom(20)
    }
}
