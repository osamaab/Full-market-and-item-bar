//
//  DeliveryAreaPickerViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 26/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

/**
 Used to enter the location information, like the:
 - name
 - city
 - address
 - building
 - floor
 - additional information
 */
class LocationInfoInputViewController: UIViewController {
    
    fileprivate var headerView = HeaderView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate var fieldsStackView = UIStackView().then {
        $0.alignment(.fill)
            .distribution(.fillEqually)
            .axis(.vertical)
            .spacing(15)
            .preparedForAutolayout()
    }
    
    fileprivate var pickerTextField = LocationPickerTextField().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate var location1TextField = PickerTextField().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.imageView.image = UIImage(named: "pin_small")
    }
    
    fileprivate var location2TextField = PickerTextField().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.imageView.image = UIImage(named: "pin_small")
    }
    
    fileprivate var location3TextField = PickerTextField().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.imageView.image = UIImage(named: "pin_small")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviews {
            headerView
            fieldsStackView
        }
        
        fieldsStackView.addingArrangedSubviews {
            pickerTextField
            location1TextField
            location2TextField
            location3TextField
        }
        
        headerView.Top == view.safeAreaLayoutGuide.Top + 15
        headerView.leading(0).trailing(0)
        
        fieldsStackView.Top == headerView.Bottom + 15
        fieldsStackView.leading(20).trailing(20)
        
        pickerTextField.height(50)
        
        [location1TextField, location2TextField, location3TextField].forEach {
            $0.isEnabled = false
        }
        
        pickerTextField.imageView.image = UIImage(named: "plus_small")
        pickerTextField.isSeparatorHidden = false
        pickerTextField.imageView.tintColor = DefaultColorsProvider.tintPrimary
        pickerTextField.onPick = { location in
            // fill the fields with the picked location
            self.pickerTextField.text = nil
            self.location1TextField.text = location?.placemark.locality
            self.location2TextField.text = location?.placemark.subLocality
            self.location1TextField.text = location?.placemark.name
        }
    }
}

private class HeaderView: UIView {
    
    let titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Delivery Area"
        $0.font = .font(for: .bold, size: 21)
    }
    
    let iconImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "delivery_area")
        $0.tintColor = DefaultColorsProvider.tintPrimary
    }
    
    let subtitleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Covering area"
        $0.font = .font(for: .bold, size: 17)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        subviews {
            titleLabel
            iconImageView
            subtitleLabel
        }
        
        iconImageView.leading(20).top(0).width(44).height(44)
        subtitleLabel.trailing(20)
        subtitleLabel.CenterY == iconImageView.CenterY
        subtitleLabel.Leading == iconImageView.Trailing + 5
        
        titleLabel.Top == iconImageView.Bottom + 5
        titleLabel.Leading == iconImageView.Leading
        titleLabel.bottom(0).trailing(20)
    }
}
