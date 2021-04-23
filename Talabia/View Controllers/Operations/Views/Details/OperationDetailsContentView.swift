//
//  OperationDetailsContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 13/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

/**
 The implementation of the operatin details uses the default card cell for the operation + it injects a list of labels inside the stack view of the operation cell
 
 Although, it uses accessory views at the bottom of the operation cell.
 */
class OperationDetailsContentView: BasicViewWithSetup {
    typealias OperationView = BaseOprationCollectionViewCell
    
    let operationDetailsView: OperationView
    let accessoryViews: [UIView]
    
    let scrollView: ScrollContainerView
    let containerStackView: UIStackView
    
    
    
    init(operationDetailsView: OperationView,
         accessoryViews: [UIView]){
        self.operationDetailsView = operationDetailsView
        self.accessoryViews = accessoryViews
        
        self.containerStackView = .init()
        self.scrollView = .init(contentView: containerStackView)
        super.init(frame: .zero)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        subviewsPreparedAL {
            scrollView
        }
        scrollView.fillContainer(padding: 15)
        
        containerStackView.alignment(.fill)
            .distribution(.fill)
            .axis(.vertical)
            .spacing(15)
        
        // adding the content views
        containerStackView.addingArrangedSubviews([operationDetailsView] + accessoryViews)
    }
    
    /**
     Use this method for adding a new view with text and title,
     you can add as much as you need, as labels will be injected inside the stackview in the operation cell,
     the view returns a field view, you can keep it for later in order to remove it if needed.
     
     Note: new labels are added to the top, so you need to reverse the order of adding new elements to this view, this behavior may change later.
     */
    @discardableResult
    func insert(text: String, for title: String) -> FieldView<UILabel> {
        let newFieldView = FieldView<UILabel>(contentView: UILabel(), title: title)
        newFieldView.titleLabel.font = .font(for: .medium, size: 16)
        newFieldView.titleLabel.textColor = DefaultColorsProvider.textSecondary1
        
        newFieldView.contentView.font = .font(for: .medium, size: 16)
        newFieldView.contentView.textColor = DefaultColorsProvider.textSecondary1
        newFieldView.contentView.text = text
        
        operationDetailsView.containerStackView.insertArrangedSubview(newFieldView, at: operationDetailsView.indexForInjectingContent + 1)
        
        return newFieldView
    }
}
