//
//  CircleConfirmButton.swift
//  talabyeh
//
//  Created by Hussein Work on 24/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class CircleConfirmButton: UIButton {
    
    enum ImageType {
        case check
        case arrow
        
        var image: UIImage? {
            switch self {
            case .check:
                return UIImage(named: "card-submit")
            case .arrow:
                return UIImage(named: "next-selected")
            }
        }
        
        var selectedImage: UIImage? {
            switch self {
            case .check:
                return UIImage(named: "card-submit-selected")
            case .arrow:
                return UIImage(named: "next-selected")
            }
        }
    }
    
    let imageType: ImageType
    
    override var isEnabled: Bool {
        didSet {
            setImage(isSelected ? imageType.selectedImage : imageType.image, for: .normal)
        }
    }
    
    init(imageType: ImageType = .check) {
        self.imageType = imageType
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        self.imageType = .check
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        isEnabled = false
    }
    
    override var intrinsicContentSize: CGSize {
        .init(width: 44, height: 44)
    }
}
