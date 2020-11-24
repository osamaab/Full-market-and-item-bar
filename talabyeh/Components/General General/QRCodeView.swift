//
//  QRCodeView.swift
//  talabyeh
//
//  Created by Hussein Work on 24/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class QRCodeView: UIView {

    let imageView: UIImageView = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        layer.borderWidth = 1
        layer.borderColor = DefaultColorsProvider.fieldBorder.cgColor
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        addSubview(imageView)
        imageView.fillContainer(padding: 15)
    }
}
