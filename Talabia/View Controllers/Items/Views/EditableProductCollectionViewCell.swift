//
//  EditableProductCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 22/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class EditableProductCollectionViewCell: ProductCollectionViewCell {
    
    let removeButton: UIButton = .init()
    
    var onRemoveButtonTap: (() -> Void)?
    
    var isEditing: Bool = false {
        didSet {
            removeButton.isHidden = !isEditing
            likeButton.isHidden = isEditing
        }
    }
    
    override func setup() {
        super.setup()
        
        containerView.subviewsPreparedAL {
            removeButton
        }
        
        removeButton.tintColor = DefaultColorsProvider.messageError
        removeButton.setImage(UIImage(named: "x-small"), for: .normal)
        
        removeButton.width(15).height(15).top(8).trailing(8)
        removeButton.add(event: .touchUpInside) { [unowned self] in
            self.onRemoveButtonTap?()
        }
        
        isEditing = false
    }
}
