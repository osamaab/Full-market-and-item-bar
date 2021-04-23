//
//  DatePickerTextField.swift
//  talabyeh
//
//  Created by Hussein Work on 03/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class DatePickerTextField: PickerTextField {

    enum DateType {
        case date
        case time
        
        var dateFormatter: DateFormatter {
            switch self {
            case .date:
                let formatter = DateFormatter()
                formatter.locale = .init(identifier: "en")
                formatter.dateFormat = "dd/MM/yyyy"
                
                return formatter
            case .time:
                let formatter = DateFormatter()
                formatter.locale = .init(identifier: "en")
                formatter.dateFormat = "hh:mm a"
                return formatter
            }
        }
    }
    
    let dateFormatter: DateFormatter!
    let type: DateType

    
    var currentDate: Date = Date() {
        didSet {
            datePicker?.date = currentDate
            _updateCurrentDate()
        }
    }

    
    public var datePicker: UIDatePicker? {
        return inputView as? UIDatePicker
    }
    
    public var onDateSelection: ((Date) -> Void)?
    
    var minDate: Date? {
        didSet {
            datePicker?.minimumDate = minDate
        }
    }
    
    var maxDate: Date? {
        didSet {
            datePicker?.maximumDate = maxDate
        }
    }
    
    // MARK: init methods
    init(type: DateType){
        self.type = type
        self.dateFormatter = type.dateFormatter
        
        super.init(frame: .zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.type = .date
        self.dateFormatter = type.dateFormatter
        super.init(coder: aDecoder)
    }
        
    override func setup() {
        super.setup()
        
        self.isSeparatorHidden = true
        self.isImageViewHidden = true
        
        _updateType()
    }

    private func _updateType() {
        inputView = nil
        let picker = UIDatePicker()
        picker.datePickerMode = type == .date ? .date : .time
        picker.date = currentDate
        
        picker.minimumDate = minDate
        picker.maximumDate = maxDate
        
        if #available(iOS 14, *) {
            picker.preferredDatePickerStyle = .wheels
            picker.sizeToFit()
        }
        
        picker.addTarget(self, action: #selector(dateValueDidChange), for: .valueChanged)
        inputView = picker
                        
        currentDate = .init()
        
        isImageViewHidden = false
        isSeparatorHidden = false
        imageView.image = UIImage(named: "calendar_picker")
        
    }
    
    private func _updateDateText() {
        if let date = datePicker?.date {
            text = dateFormatter.string(from: date)
        } else {
            text = nil
        }
    }
    
    private func _updateCurrentDate() {
        _updateDateText()
    }
    
    @objc private func dateValueDidChange() {
        _updateDateText()
    }
}
