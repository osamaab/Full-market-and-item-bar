//
//  ToggleButton.swift
//  talabyeh
//
//  Created by Hussein Work on 16/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class ToggleButton: UIButton {
    
    var unselectedImage: UIImage? {
        didSet {
            updateState()
        }
    }
    
    var selectedImage: UIImage? {
        didSet {
            updateState()
        }
    }
    
    var isChecked: Bool = false {
        didSet {
            updateState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        self.isChecked = false
        
        add(event: .touchUpInside){ [unowned self] in
            self.isChecked = !self.isChecked
            self.sendActions(for: .valueChanged)
        }
    }
    
    func toggle(){
        self.isChecked = !isChecked
    }
    
    func updateState(){
        self.setImage(isChecked ? selectedImage : unselectedImage, for: .normal)
    }
}

class FavoriteButton: ToggleButton {
    override func setup(){
        super.setup()

        self.unselectedImage = .named("favorite-unselected")
        self.selectedImage = .named("favorite-selected")
    }
}



class CheckboxSquareButton: ToggleButton {
    override func setup() {
        super.setup()
        
        self.unselectedImage = .named("checkbox_unselecteed")
        self.selectedImage = .named("checkbox_selected")
    }
}
