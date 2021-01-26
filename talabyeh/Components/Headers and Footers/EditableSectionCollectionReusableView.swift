//
//  EditableSection.swift
//  talabyeh
//
//  Created by Hussein Work on 22/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class EditableSectionCollectionReusableView: TintedLabelCollectionReusableView {

    let editButton: UIButton = .init()
    
    var onEdit: (() -> Void)?
    
    var isEditing: Bool = false {
        didSet {
            editButton.setTitle(isEditing ? "Done" : "Edit", for: .normal)
        }
    }
    
    override func setup() {
        editButton.titleLabel?.font = .font(for: .semiBold, size: 17)
        editButton.setTitleColor(DefaultColorsProvider.secondaryText, for: .normal)
        
        subviewsPreparedAL {
            editButton
        }
        
        editButton.add(event: .touchUpInside) { [unowned self] in
            onEdit?()
        }
        
        super.setup()
        isEditing = false
    }
    
    override func setupConstraints(){
        titleLabel.fillVertically(padding: verticalPadding)
        titleLabel.leading(horizontalPadding)
        
        editButton.fillVertically(padding: verticalPadding)
        editButton.trailing(horizontalPadding)
        
        titleLabel.Trailing <= editButton.Leading - 10
    }
}
