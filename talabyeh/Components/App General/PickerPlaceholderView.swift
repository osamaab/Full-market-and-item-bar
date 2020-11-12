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
    
    var style: Style = .inactive {
        didSet {
            
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
        backgroundColor = UIColor(rgb: 0x9AA1B1)
        layer.cornerRadius = 10
        
        stackView
            .axis(.vertical)
            .alignment(.center)
            .spacing(8)
            .preparedForAutolayout()
        
        stackView.addingArrangedSubviews([imageView, titleLabel])
        
        addSubview(stackView)
        stackView.fillContainer(padding: 20)
        
        // putting a sample image
        titleLabel.font = .font(for: .regular, size: 16)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        imageView.contentMode = .scaleAspectFit
        
        // sample conetnt
        imageView.image = UIImage(named: "camera")
        titleLabel.text = "Personal ID"
        
        self.update(for: style)
    }
    
    func update(for style: Style){
        
    }
}
