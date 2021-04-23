//
//  ProfilePDFContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 08/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class ProfilePDFContentView: BasicViewWithSetup {

    let titleView: LabelView = .init(title: "Company Profile", icon: UIImage(named: "menu_profile"))
    
    let uploadView = UploadCertificateView().then {
        $0.plusButton.isHidden = true
    }
    
    let imageView = ImagePickerPlaceholderView(title: "Upload Certificate", image: UIImage(named: "camera"))
    
    override func setup() {
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        subviewsPreparedAL {
            titleView
            uploadView
            imageView
        }
        
        titleView.top(0).leading(0).trailing(0)
        uploadView.leading(0).trailing(0)
        
        uploadView.Top == titleView.Bottom + 15
        
        imageView.Top == uploadView.Bottom + 15
        imageView.leading(0).trailing(0).bottom(0)
        imageView.height(150)
    }
}
