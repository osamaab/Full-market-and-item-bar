//
//  ChangeAvatarView.swift
//  talabyeh
//
//  Created by Hussein Work on 23/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class ChangeAvatarView: BasicViewWithSetup {
    
    let imageView: UIImageView = .init()
    let iconView: UIImageView = .init()
    
    fileprivate var imagePicker: ImagePickerController?
    
    var isEditable: Bool = true {
        didSet {
            iconView.isHidden = !isEditable
        }
    }
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    override func setup() {
        layer.borderWidth = 1
        layer.borderColor = DefaultColorsProvider.fieldBorder.cgColor
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        iconView.contentMode = .scaleAspectFit
        iconView.image = UIImage(named: "camera")
        iconView.tintColor = DefaultColorsProvider.placeholder
        
        subviewsPreparedAL {
            imageView
            iconView
        }
        
        
        iconView.centerInContainer().width(25).height(25)
        imageView.fillContainer()
        
        addAction { [unowned self] in
            if self.isEditable {
                self.presentImagePicker()
            }
        }
        
        let temp = isEditable
        self.isEditable = temp
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        imageView.layer.cornerRadius = bounds.height / 2
    }
    
    fileprivate func presentImagePicker(){
        if let topViewController = UIApplication.topViewController() {
            imagePicker = ImagePickerController(presentationController: topViewController,
                                  delegate: self)
            imagePicker?.present(from: self)
        }
    }
}

extension ChangeAvatarView: ImagePickerControllerDelegate {
    func imagePickerController(_ sender: ImagePickerController, didFinishWith image: UIImage?) {
        self.image = image
    }
}
