//
//  CertificatePDFContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 08/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CertificatePDFContentView: BasicViewWithSetup {

    let uploadView = UploadCertificateView().then {
        $0.plusButton.isHidden = false
        $0.titleLabel.text = "Upload Certificate"
    }
    
    let imageView = ImagePickerPlaceholderView(title: "Upload Certificate", image: UIImage(named: "camera"))
    
    override func setup() {
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        subviewsPreparedAL {
            uploadView
            imageView
        }
        
        uploadView.top(0).leading(0).trailing(0)
        
        imageView.Top == uploadView.Bottom + 15
        imageView.leading(0).trailing(0).bottom(0)
        imageView.height(150)
    }
}
