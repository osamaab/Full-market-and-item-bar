//
//  NewDistributerViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 15/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia
import Actions

class NewDistributerViewController: UIViewController {
    
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
    let moneyDistributionView = NDMoneyDistributionContentView()
    
    var currentImageSelectMode: ImageSelectMode = .personalID
    
    fileprivate var deliveryAreaLocation: Location? {
        didSet {
            deliveryAreaView.locationTextField.text = deliveryAreaLocation?.address
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hidesBottomBarWhenPushed = true
        setupViews()
        setupCardViews()
    }
    
    fileprivate func setupViews(){
        self.view.backgroundColor = DefaultColorsProvider.background1
        
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
    }
    
    fileprivate func setupCardViews(){
        contentView.titleLabel.text = "New Distributor"
        
        contentView.insertCardView(with: personalInformationView, title: "Personal Information")
        contentView.insertCardView(with: carInformationView, title: "Car Information")
        let deliveryAreaCardView = contentView.insertCardView(with: deliveryAreaView, title: "Delivery Area")
        contentView.insertCardView(with: availabilityView, title: "Availability")
        contentView.insertCardView(with: moneyDistributionView, title: "Where to distribute his money")
        
        
        // we need to add the plus button :)
        let plusButton = UIButton()
        plusButton.setImage(UIImage(named: "plus_small"), for: .normal)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.width(20).height(20)
        
        deliveryAreaCardView.addSubview(plusButton)
        plusButton.CenterY == deliveryAreaCardView.titleLabel.CenterY
        plusButton.top(20).trailing(20)
        plusButton.tintColor = DefaultColorsProvider.darkerTint
        
        plusButton.add(event: .touchUpInside) { [unowned self] in
            self.deliveryAreaPickerTapped()
        }
        
        personalInformationView.personalIDPickerView.onTap = personalIDPickerTapped
        personalInformationView.drivingLicensePickerView.onTap = drivingLicensePickerTapped
        carInformationView.picturesPickerView.onTap = carPicturesPickerTapped
        carInformationView.licensePickerView.onTap = carLicensePickerTapped
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
}


//MARK: Actions
extension NewDistributerViewController {
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
    
    @objc func deliveryAreaPickerTapped(){
        LocationPickerController(title: "Delivery Area", location: deliveryAreaLocation, delegate: self).present(on: self)
    }
}

extension NewDistributerViewController: ImagePickerControllerDelegate {
    func imagePickerController(_ sender: ImagePickerController, didFinishWith image: UIImage?) {
        guard let image = image else {
            return
        }
        
        let picker = pickerView(for: currentImageSelectMode)
        picker.associatedValue = image
    }
}

extension NewDistributerViewController: LocationPickerControllerDelegate {
    func locationPickerController(_ sender: LocationPickerController, didFinishWith location: PickedLocation?) {
        guard let location = location else {
            return
        }
        
        deliveryAreaLocation = location
    }
}
