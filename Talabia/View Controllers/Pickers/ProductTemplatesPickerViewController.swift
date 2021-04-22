//
//  ProductTemplatesPickerViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 18/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import PickerView
import Stevia


protocol ProductTemplatesPickerViewControllerDelegate: class {
    func productTemplatesPickerViewController(_ sender: ProductTemplatesPickerViewController, didFinishWith productTempalte: ProductTemplate)
}

class ProductTemplatesPickerViewController: ContentViewController<[ProductTemplate]> {

    override var requiresAuthentication: Bool {
        false
    }
    
    weak var delegate: ProductTemplatesPickerViewControllerDelegate?
    
    let pickerView: PickerView = .init()
    let bottomView: BottomNextButtonView = .init(title: "Next")
    
    var filterCategory: SubCategory?
    
    fileprivate(set) var items: [ProductTemplate] = []
    
    convenience init(){
        self.init(contentRepository: APIContentRepositoryType<ItemsAPI, [ProductTemplate]>(.productTemplates))
    }
    
    var selectedProduct: ProductTemplate?
    override func setupViewsBeforeTransitioning() {
        view.subviewsPreparedAL { () -> [UIView] in
            pickerView
            bottomView
        }
        
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        pickerView.Top == view.safeAreaLayoutGuide.Top
        pickerView.leading(0).trailing(0)
        
        bottomView.bottom(0).leading(0).trailing(0)
        pickerView.Bottom == bottomView.Top

        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        bottomView.nextButton.add(event: .touchUpInside) { [unowned self] in
            if let index = self.pickerView.currentSelectedRow {
                self.dismiss(animated: true) {
                    self.delegate?.productTemplatesPickerViewController(self, didFinishWith: unwrappedContent[index])
                }
            }
        }
    }
    
    override func contentRequestDidSuccess(with content: [ProductTemplate]) {
        if let filter = self.filterCategory {
            self.items = content.filter { $0.subcategoryID == filter.id }
        } else {
            self.items = content
        }
        
        pickerView.reloadPickerView()
        
        if let product = self.selectedProduct, let index = items.firstIndex(of: product){
            pickerView.selectRow(index, animated: true)
        }
    }
}

extension ProductTemplatesPickerViewController: PickerViewDataSource, PickerViewDelegate {
    func pickerViewNumberOfRows(_ pickerView: PickerView) -> Int {
        items.count
    }
    
    func pickerView(_ pickerView: PickerView, titleForRow row: Int) -> String {
        let item = items[row]
        return item.name
    }
    
    func pickerView(_ pickerView: PickerView, styleForLabel label: UILabel, highlighted: Bool) {
        
        label.textAlignment = .center
        if highlighted {
            label.textColor = DefaultColorsProvider.tintPrimary
            label.font = .font(for: .bold, size: 28)
        } else {
            label.textColor = DefaultColorsProvider.textSecondary2
            label.font = .font(for: .regular, size: 28)
        }
    }
    
    func pickerViewHeightForRows(_ pickerView: PickerView) -> CGFloat {
        60
    }
}
