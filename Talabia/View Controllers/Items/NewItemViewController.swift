//
//  NewItemViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 21/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

protocol NewItemViewControllerDelegate: class {
    func newItemViewController(_ sender: NewItemViewController, didFinishWith product: NewItemInput)
}

class NewItemViewController: ContentViewController<[ProductUnit]> {
    
    let categoryView = TintedLabelCollectionReusableView(verticalPadding: 20, horizontalPadding: 20)
    let fieldsInputView = NewItemInputFieldsContentView()
    let bottomNextView = BottomNextButtonView(title: "Save")
    
    lazy var scrollView: ScrollContainerView = .init(contentView: fieldsInputView)
    
    weak var delegate: NewItemViewControllerDelegate?
    
    let category: SubCategory
    
    init(category: SubCategory) {
        self.category = category
        super.init(contentRepository: APIContentRepositoryType<GeneralAPI, [ProductUnit]>(.units))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViewsBeforeTransitioning() {
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        view.subviewsPreparedAL {
            categoryView
            scrollView
            bottomNextView
        }
        
        categoryView.Top == view.safeAreaLayoutGuide.Top + 20
        categoryView.leading(20).trailing(20)
        
        scrollView.Top == categoryView.Bottom + 20
        scrollView.leading(0).trailing(0).bottom(0)
        
        bottomNextView.bottom(0).leading(0).trailing(0)
        
        categoryView.titleLabel.font = .font(for: .semiBold, size: 17)
        categoryView.title = category.title
        
        fieldsInputView.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        bottomNextView.nextButton.add(event: .touchUpInside) { [unowned self] in
            guard let name = self.fieldsInputView.nameTextField.product,
                  let unitID = self.fieldsInputView.unitTextField.selectedItem?.id,
                  let price = self.fieldsInputView.priceTextField.text,
                  let quantity = self.fieldsInputView.quantityTextField.text,
                  let production = self.fieldsInputView.productionDateTextField.text,
                  let expiration = self.fieldsInputView.expirationDateTextField.text
            else {
                self.showMessage(message: "Please fill all fields", messageType: .failure)
                return
            }
            
            let images = self.fieldsInputView.imagesPickerView.images.compactMap { $0.toBase64() }
            if images.isEmpty {
                self.showMessage(message: "Please Add Images", messageType: .failure)
                return
            }
            
            let input = NewItemInput(itemId: name.id, price: Double(price) ?? 0, quantity: Int(quantity) ?? 0, description: fieldsInputView.descriptionTextView.text ?? "", moreDetails: "", unitId: Int(unitID)!, productionDate: production, expirationDate: expiration, imagesB64: images)
            
            self.delegate?.newItemViewController(self, didFinishWith: input)
        }
    }
    
    override func contentRequestDidSuccess(with content: [ProductUnit]) {
        self.fieldsInputView.unitTextField.choices = content.map { AnyChoiceItem(id: "\($0.id)", title: $0.title) }
        self.fieldsInputView.nameTextField.filterCategory = self.category
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.scrollView.contentInset.bottom = bottomNextView.bounds.height
    }
}
