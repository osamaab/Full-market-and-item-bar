//
//  ChoicesPickerTextField.swift
//  talabyeh
//
//  Created by Hussein Work on 21/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class ChoicesPickerTextField<ChoiceItem: ChoiceItemType>: PickerTextField, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var choices: [ChoiceItem] {
        didSet {
            if self.selectedIndex == nil, choices.count > 0 {
                self.selectedIndex = 0
            }
            
            pickerView?.reloadAllComponents()
        }
    }
    
    var selectedItem: ChoiceItem? {
        guard let selectedIndex = selectedIndex else {
            return nil
        }
        
        return choices[selectedIndex]
    }
    
    var selectedIndex: Int? {
        didSet {
            updateText()
        }
    }
    
    public var pickerView: UIPickerView? {
        return inputView as? UIPickerView
    }
    
    init(choices: [ChoiceItem], selectedChoice: ChoiceItem? = nil){
        self.choices = choices
        self.selectedIndex = choices.firstIndex { $0.id == selectedChoice?.id }
        
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        super.setup()
        
        inputView = nil
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        
        inputView = picker
    }
    
    fileprivate func updateText(){
        guard let item = self.selectedItem else {
            self.text = nil
            return
        }
        
        self.text = item.title
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        choices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        choices[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedIndex = row
        updateText()
    }
}
