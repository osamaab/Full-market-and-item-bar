//
//  ContactFormView.swift
//  talabyeh
//
//  Created by Hussein Work on 15/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class ContactFormView: BasicViewWithSetup {

    let labelView = LabelView(title: "Company Profile", icon: UIImage(named: ""))
    let contactView = TintedLabelCollectionReusableView(verticalPadding: 12, horizontalPadding: 20)
    let textView = TextView(frame: .zero)
    let sendButton = RoundedFillButton()
    
    
    override func setup() {
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        subviewsPreparedAL {
//            labelView
//            contactView
            textView
//            sendButton
        }
        
        sendButton.contentEdgeInsets = .init(top: 12, left: 20, bottom: 12, right: 20)
        sendButton.setTitle("Send", for: .normal)
        textView.placeholder = "Message"
        contactView.titleLabel.text = "Contact our Designers"
        
        labelView.leading(0).trailing(0).top(0)
        contactView.leading(0).trailing(0)
//        textView.leading(0).trailing(0).height(100)
        textView.leading(10).trailing(10).height(100%)
        sendButton.width(70%).centerHorizontally().bottom(0)
        
        contactView.Top == labelView.Bottom + 15
//        textView.Top == contactView.Bottom
        sendButton.Top == textView.Bottom + 15
    }
}
