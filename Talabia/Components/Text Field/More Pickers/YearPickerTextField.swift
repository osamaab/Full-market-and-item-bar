//
//  YearPickerTextField.swift
//  talabyeh
//
//  Created by Hussein Work on 17/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class YearPickerTextField: PickerTextField {
    
    fileprivate var dateFormatter: DateFormatter = .init()
    
    lazy var years: [Int] = {
        var years: [Int] = []
        if years.count == 0 {
            var year = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date)
            for _ in 1...15 {
                years.append(year)
                year += 1
            }
        }
        
        return years
    }()
    
    var year = Calendar.current.component(.year, from: Date()) {
        didSet {
            pickerView?.selectRow(years.firstIndex(of: year)!, inComponent: 0, animated: true)
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
        self.text = "\(self.year)"
    }
}


extension YearPickerTextField: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(years[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.year = years[row]
        updateText()
    }
}
