//
//  EditDistributorViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 25/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class EditDistributorViewController: NewDistributorViewController {
    
    let distributor: Distributor
    
    init(distributor: Distributor){
        self.distributor = distributor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.personalInformationView.nameTextfield.text = distributor.name
        self.personalInformationView.emailTextField.text = distributor.email
        self.personalInformationView.mobileTextField.text = distributor.mobile
        
        self.personalInformationView.passwordTextField.isHidden = true
        
        self.personalInformationView.personalIDPickerView.associatedValue = NSObject()
        self.personalInformationView.drivingLicensePickerView.associatedValue = NSObject()
        self.carInformationView.picturesPickerView.associatedValue = NSObject()
        self.carInformationView.licensePickerView.associatedValue = NSObject()
    }
    
    override func validateAndReturnInfo() throws -> NewDistributorInput {
        guard let name = self.personalInformationView.nameTextfield.text,
              let email = self.personalInformationView.emailTextField.text,
              let mobile = self.personalInformationView.mobileTextField.text else {
            
            throw InputCardViewValidationError.missingFields
        }
        
        guard !deliveryAreaView.deliveryAreaView.selectedCities.isEmpty else {
            throw InputCardViewValidationError.missingFields
        }
        
        let personalID = self.personalInformationView.personalIDPickerView.associatedValue as? UIImage
        let drivingLicense = self.personalInformationView.drivingLicensePickerView.associatedValue  as? UIImage
        let carLicense = self.carInformationView.picturesPickerView.associatedValue as? UIImage
        let carPicture = self.carInformationView.licensePickerView.associatedValue as? UIImage
         
//        guard let weekdays = self.availabilityView.datesTextField.workingDays(with: self.availabilityView.timesTextField.selectedFirstTime, endTime: self.availabilityView.timesTextField.selectedEndTime) else {
//
//            self.showMessage(message: "Please Enter all fields", messageType: .failure)
//            return
//        }
        
        let input = NewDistributorInput(enName: name, email: email, password: nil, mobile: mobile, personalIdB64: personalID?.toBase64()!, drivingLicenseB64: drivingLicense?.toBase64()!, carLicenseB64: carLicense?.toBase64()!, carPictureB64: carPicture?.toBase64()!)
        
        return input
    }
}
