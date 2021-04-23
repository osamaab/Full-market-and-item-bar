//
//  MonthPickerTextField.swift
//  talabyeh
//
//  Created by Hussein Work on 17/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class MonthPickerTextField: PickerTextField {
    
    fileprivate var dateFormatter: DateFormatter = .init()
    
    lazy var months: [String] = {
        dateFormatter.monthSymbols
    }()
    
    var month = Calendar.current.component(.month, from: Date()) {
        didSet {
            pickerView?.selectRow(month-1, inComponent: 0, animated: false)
        }
    }
    
    public var pickerView: UIPickerView? {
        return inputView as? UIPickerView
    }
    
    override func setup() {
        super.setup()
        
        inputView = nil
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        

        let currentMonth = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.month, from: NSDate() as Date)
        picker.selectRow(currentMonth - 1, inComponent: 0, animated: false)


        inputView = picker
        updateText()
    }
    
    fileprivate func updateText(){
        self.text = self.months[month - 1]
    }
}


extension MonthPickerTextField: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        months.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        months[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.month = row + 1
        updateText()
    }
}
