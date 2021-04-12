//
//  NewDistributorViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 15/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia
import Actions

protocol NewDistributerViewControllerDelegate: class {
    func newDistributerViewController(_ sender: NewDistributorViewController, didFinishWith form: NewDistributorInput)
}

class NewDistributorViewController: UIViewController {
    
    enum ImageSelectMode {
        case personalID
        case drivingLicense
        case carPictures
        case carLicense
    }

    let contentView: NewDistributerContentView = .init()
    let bottomView: BottomNextButtonView = .init(title: "Save")
    
    let personalInformationView = NDPersonalInformationContentView()
    let carInformationView = NDCarInformationContentView()
    let deliveryAreaView = NDDeliveryAreaContentView()
    let availabilityView = NDAvailabilityContentView()
    let moneyDistributionView = NDPaymentMethodPickerContentView(paymentMethods: [])
    
    fileprivate var currentImageSelectMode: ImageSelectMode = .personalID
    
    weak var delegate: NewDistributerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.scrollContainerView.scrollView.contentInset.bottom += 100
        
        view.subviews {
            contentView
            bottomView
        }
        
        contentView.left(0).right(0)
        contentView.Top == view.safeAreaLayoutGuide.Top
        contentView.Bottom == view.safeAreaLayoutGuide.Bottom
        
        bottomView.right(0).left(0).bottom(0)
        setupCardViews()
    }

    fileprivate func setupCardViews(){
        contentView.titleLabel.text = "New Distributor"
        
        contentView.insertCardView(with: personalInformationView, title: "Personal Information")
        contentView.insertCardView(with: carInformationView, title: "Car Information")
        contentView.insertCardView(with: deliveryAreaView, title: "Delivery Area")
        contentView.insertCardView(with: availabilityView, title: "Availability")
        contentView.insertCardView(with: moneyDistributionView, title: "Where to distribute his money")
        
        
        personalInformationView.personalIDPickerView.onTap = personalIDPickerTapped
        personalInformationView.drivingLicensePickerView.onTap = drivingLicensePickerTapped
        carInformationView.picturesPickerView.onTap = carPicturesPickerTapped
        carInformationView.licensePickerView.onTap = carLicensePickerTapped
        
        moneyDistributionView.add(paymentMethod: .init(id: "visa", image: nil, title: "VISA 1910"))
        moneyDistributionView.add(paymentMethod: .init(id: "mastercard", image: nil, title: "MASTERCARD 1913"))
        
        
        bottomView.nextButton.add(event: .touchUpInside) { [unowned self] in
            self.perform()
        }
    }
    
    fileprivate func presentImagePicker(for mode: ImageSelectMode){
        self.currentImageSelectMode = mode
        ImagePickerController(presentationController: self, delegate: self).present(from: self.pickerView(for: mode))
    }
    
    fileprivate func pickerView(for mode: ImageSelectMode) -> PickerPlaceholderView {
        switch mode {
        case .personalID:
            return personalInformationView.personalIDPickerView
        case .drivingLicense:
            return personalInformationView.drivingLicensePickerView
        case .carPictures:
            return carInformationView.picturesPickerView
        case .carLicense:
            return carInformationView.licensePickerView
        }
    }
    
    func validateAndReturnInfo() throws -> NewDistributorInput {
        guard let personalID = self.personalInformationView.personalIDPickerView.associatedValue as? UIImage,
              let drivingLicense = self.personalInformationView.drivingLicensePickerView.associatedValue as? UIImage,
              let carPicture = self.carInformationView.picturesPickerView.associatedValue as? UIImage,
              let carLicense = self.carInformationView.licensePickerView.associatedValue as? UIImage else {
            
            throw InputCardViewValidationError.missingFields
        }
        
        guard let name = self.personalInformationView.nameTextfield.text,
              let email = self.personalInformationView.emailTextField.text,
              let mobile = self.personalInformationView.mobileTextField.text,
              let password = self.personalInformationView.passwordTextField.text else {
            
            throw InputCardViewValidationError.missingFields
        }
        
        guard !deliveryAreaView.deliveryAreaView.selectedCities.isEmpty else {
            
            throw InputCardViewValidationError.missingFields
        }
        
//        guard let weekdays = self.availabilityView.datesTextField.workingDays(with: self.availabilityView.timesTextField.selectedFirstTime, endTime: self.availabilityView.timesTextField.selectedEndTime) else {
//
//            self.showMessage(message: "Please Enter all fields", messageType: .failure)
//            return
//        }
        
        let input = NewDistributorInput(enName: name, email: email, password: password, mobile: mobile, personalIdB64: personalID.toBase64()!, drivingLicenseB64: drivingLicense.toBase64()!, carLicenseB64: carLicense.toBase64()!, carPictureB64: carPicture.toBase64()!)
        
        return input
    }
}

//MARK: Actions
extension NewDistributorViewController {
    @objc func personalIDPickerTapped(){
        presentImagePicker(for: .personalID)
    }
    
    @objc func drivingLicensePickerTapped(){
        presentImagePicker(for: .drivingLicense)
    }
    
    @objc func carPicturesPickerTapped(){
        presentImagePicker(for: .carPictures)
    }
    
    @objc func carLicensePickerTapped(){
        presentImagePicker(for: .carLicense)
    }
    
    
    
    @objc func perform(){
        do {
            let input = try self.validateAndReturnInfo()
            self.delegate?.newDistributerViewController(self, didFinishWith: input)
        } catch {
            self.showMessage(message: error.localizedDescription, messageType: .failure)
        }
    }
}

extension NewDistributorViewController: ImagePickerControllerDelegate {
    func imagePickerController(_ sender: ImagePickerController, didFinishWith image: UIImage?) {
        guard let image = image else {
            return
        }
        
        let picker = pickerView(for: currentImageSelectMode)
        picker.associatedValue = image
    }
}
