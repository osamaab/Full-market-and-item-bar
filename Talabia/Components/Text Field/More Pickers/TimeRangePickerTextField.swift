//
//  TimeRangePickerTextField.swift
//  talabyeh
//
//  Created by Hussein Work on 16/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class TimeRangePickerTextField: PickerTextField {

    lazy var startTimes: [String] = getTimeList(from: 0)
    
    var startingTimeIndex: Int = 0 {
        didSet {
            pickerView?.reloadComponent(1)
        }
    }
    
    var endTimes: [String] {
        getTimeList(from: startingTimeIndex)
    }
    
    let timeFormatter = DateFormatter()
    
    
    var selectedFirstTime: String? {
        guard let selectedFirst = pickerView?.selectedRow(inComponent: 0) else {
            return nil
        }
        
        return startTimes[selectedFirst]
    }
    
    
    var selectedEndTime: String? {
        guard let selectedFirst = pickerView?.selectedRow(inComponent: 1) else {
            return nil
        }
        
        return endTimes[selectedFirst]
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
        
        timeFormatter.timeStyle = .short
        inputView = picker
        
        imageView.image = UIImage(named: "time_picker")
    }
    
    fileprivate func updateText(){
        guard let selectedFirst = pickerView?.selectedRow(inComponent: 0),
              let selectedSecond = pickerView?.selectedRow(inComponent: 1) else {
            return
        }
        
        let startTime = startTimes[selectedFirst]
        let endTime = endTimes[selectedSecond]
        
        if startTime != endTime {
            self.text = "\(startTime) - \(endTime)"
        } else {
            self.text = startTime
        }
    }
    
    func select(startTime: String, endTime: String){
//        self.pickerView?.selectRow(<#T##row: Int##Int#>, inComponent: <#T##Int#>, animated: <#T##Bool#>)
    }
}

extension TimeRangePickerTextField: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
           
        case 0:
            return startTimes.count
        default:
            return endTimes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return startTimes[row]
        default:
            return endTimes[row]
        }
    }
   
    //this is for reloading the END times list, according to the value selected as the START time.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0) {
            self.startingTimeIndex = row
        }
        
        updateText()
    }
}

extension TimeRangePickerTextField {
    func getTimeList(from: Int) -> [String] {
        let alllist: [String] = [
            "1:00 AM","2:00 AM","3:00 AM","4:00 AM","5:00 AM", "6:00 AM", "7:00 AM", "8:00 AM", "9:00 AM","10:00 AM","11:00 AM", "12:00 PM", "1:00 PM", "2:00 PM", "3:00 PM", "4:00 PM", "5:00 PM", "6:00 PM", "7:00 PM", "8:00 PM", "9:00 PM", "10:00 PM", "11:00 PM", "12:00 AM"]
        var list: [String] = []
        for i in from...alllist.count-1 {
            list.append(alllist[i])
        }
        return list
    }
}
