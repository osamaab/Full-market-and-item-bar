//
//  PickerPlaceholderView.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class PickerPlaceholderView: UIView {
    
    enum Style {
        case active
        case inactive
    }
    
    let stackView: UIStackView = .init()
    let titleLabel: UILabel = .init()
    let imageView: UIImageView = .init()
    
    /**
     sometimes it's better to save the information here, ex. the image.
     */
    var associatedValue: AnyObject? {
        didSet {
            self.style = associatedValue == nil ? .inactive : .active
        }
    }
    
    var onTap: (() -> Void)?
    var onClear: (() -> Void)?
    
    var style: Style = .inactive {
        didSet {
            update(for: style)
        }
    }
    
    init(title: String? = nil, image: UIImage? = nil){
        super.init(frame: .zero)
        setup()
        
        self.titleLabel.text = title
        self.imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        backgroundColor = DefaultColorsProvider.containerBackground1
        layer.cornerRadius = 10
        
        stackView
            .axis(.vertical)
            .alignment(.center)
            .spacing(8)
            .preparedForAutolayout()
        
        stackView.addingArrangedSubviews([imageView, titleLabel])
        
        addSubview(stackView)
        stackView.leading(20).trailing(20).top(>=20).centerVertically()
        
        // putting a sample image
        titleLabel.font = .font(for: .regular, size: 16)
        titleLabel.textColor = DefaultColorsProvider.backgroundPrimary
        titleLabel.textAlignment = .center
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = DefaultColorsProvider.backgroundPrimary
        
        self.update(for: style)
        
        let gesture = addAction { [unowned self] in
            self.onTap?()
        }
        gesture.cancelsTouchesInView = false
    }
    
    func update(for style: Style){
        self.backgroundColor = style == .inactive ? DefaultColorsProvider.containerBackground1 : DefaultColorsProvider.tintSecondary
        self.titleLabel.textColor = style == .inactive ? DefaultColorsProvider.backgroundPrimary : DefaultColorsProvider.tintPrimary
        self.imageView.tintColor = style == .inactive ? DefaultColorsProvider.backgroundPrimary : DefaultColorsProvider.tintPrimary
    }
}


class ImagePickerPlaceholderView: PickerPlaceholderView, ImagePickerControllerDelegate {
    
    var image: UIImage? {
        associatedValue as? UIImage
    }
    
    var imagePicker: ImagePickerController?
    
    override func setup() {
        super.setup()
        
        onTap = { [unowned self] in
            
            if let topVC = UIApplication.topViewController() {
                self.imagePicker = .init(presentationController: topVC,
                                         delegate: self)
                self.imagePicker?.present(from: self)
            }
        }
    }
    
    func imagePickerController(_ sender: ImagePickerController, didFinishWith image: UIImage?) {
        self.associatedValue = image
    }
}
