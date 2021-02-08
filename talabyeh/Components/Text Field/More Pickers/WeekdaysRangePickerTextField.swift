//
//  WeekdaysRangePickerTextField.swift
//  talabyeh
//
//  Created by Hussein Work on 16/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class WeekdaysRangePickerTextField: PickerTextField {
    
    lazy var startingWeekday: Weekday = Weekday.sun {
        didSet {
            pickerView?.reloadComponent(1)
        }
    }
    
    var weekdays: [Weekday] = Weekday.allCases
    
    lazy var startingWeekdayList: [Weekday] = weekdays
    
    var endWeekdayList: [Weekday] {
        startingWeekday.weekdaysAfter()
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
        
        inputView = picker
        imageView.image = UIImage(named: "calendar_picker")
    }
    
    fileprivate func updateText(){
        guard let selectedFirst = pickerView?.selectedRow(inComponent: 0),
              let selectedSecond = pickerView?.selectedRow(inComponent: 1) else {
            return
        }
        
        let startWeekday = startingWeekdayList[selectedFirst]
        let endWeekday = endWeekdayList[selectedSecond]
        
        if startWeekday != endWeekday {
            self.text = "\(startWeekday.text) - \(endWeekday.text)"
        } else {
            self.text = startWeekday.text
        }
    }
}

extension WeekdaysRangePickerTextField: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        component == 0 ? startingWeekdayList.count : endWeekdayList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        switch component {
        case 0:
            return startingWeekdayList[row].text
        default:
            return endWeekdayList[row].text
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            startingWeekday = startingWeekdayList[row]
        }
        
        // update the text
        updateText()
    }
}

enum Weekday: Int, CaseIterable, Comparable {
    case sun = 1
    case mon
    case tue
    case wed
    case thu
    case fri
    case sat
    
    /**
     The name of the weekday
     */
    var text: String {
        let sat = "Saturday".localiz()
        let sun = "Sunday".localiz()
        let mon = "Monday".localiz()
        let tue = "Tuesday".localiz()
        let wed = "Wensday".localiz()
        let thu = "Thursday".localiz()
        let fri = "Friday".localiz()
        
        switch self {
        case .sat: return sat
        case .sun: return sun
        case .mon: return mon
        case .tue: return tue
        case .wed: return wed
        case .thu: return thu
        case .fri: return fri
        }
    }
    
    func weekdaysAfter() -> [Weekday] {
        let allWeekdays = Self.allCases.sorted()
        let indexOfSelf = allWeekdays.firstIndex(of: self)!
        return Array(allWeekdays[indexOfSelf..<(indexOfSelf + (allWeekdays.count - indexOfSelf))])
    }
    
    static func < (lhs: Weekday, rhs: Weekday) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
