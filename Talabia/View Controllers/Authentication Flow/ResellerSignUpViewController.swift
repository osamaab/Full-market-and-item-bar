//
//  ResellerSignUpViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 07/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator
import Stevia

protocol ResellerSignUpViewControllerDelegate: class {
    func resellerSignUpViewController(sender: ResellerSignUpViewController, didFinishWith reseller: RegisterationForm.Reseller)
}

class ResellerSignUpViewController: UIViewController {
    
    enum ImagePickMode: Int {
        case logo
        case license
    }
    
    lazy var scrollView: ScrollContainerView = .init(contentView: contentView)
    lazy var contentView = ResellerSignUpContentView()
    lazy var bottomNextView: BottomNextButtonView = .init(title: "Save")
        
    fileprivate var imagePickMode: ImagePickMode = .logo
    
    weak var delegate: ResellerSignUpViewControllerDelegate?
    
    let categories: [MainCategory]
    let subCategories: [SubCategory]
    var logoImage: UIImage? {
        didSet {
            updatePickersState()
        }
    }
    
    var licenseImage: UIImage? {
        didSet {
            updatePickersState()
        }
    }
    
    var worningImage: UIImage? {
        didSet {
            updatePickersState()
        }
    }
    var storeLocation: Location? {
        didSet {
            updatePickersState()
        }
    }
    
    init(categories: [MainCategory], subCategories: [SubCategory]){
        self.categories = categories
        self.subCategories = subCategories
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Signup"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hex: "#9AA1B1")]
        super.viewDidLoad()
        
        setupViews()
        addValidation()
        connectActions()
        updatePickersState()
    }
    
    fileprivate func setupViews(){
        
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            scrollView
            bottomNextView
        }
        
        scrollView.Top == view.safeAreaLayoutGuide.Top + 20
        scrollView.leading(20).trailing(20).bottom(0)
        
        bottomNextView.leading(0).trailing(0).bottom(0)
    }
    
    func verifyContent() throws -> RegisterationForm.Reseller {
        guard let license = self.licenseImage else {
            contentView.licenceWorningImageView.isHidden = false
            throw InputCardViewValidationError.missingFields
        }
        contentView.licenceWorningImageView.isHidden = true
        
        guard let logo = self.logoImage else {
            contentView.storeWorningImageView.isHidden = false
            throw InputCardViewValidationError.missingFields
        }
        contentView.storeWorningImageView.isHidden = true
        guard let location = self.storeLocation else {
            contentView.storeLocationWorningImageView.isHidden = false
            throw InputCardViewValidationError.missingFields
        }
        contentView.storeLocationWorningImageView.isHidden = true
        
        guard let name = self.contentView.nametf.text,
              let email = self.contentView.emailtf.text,
              let password = self.contentView.passwordtf.text,
              let nationalNumber = self.contentView.nationalNumbertf.text,
              let telephone = self.contentView.telephonetf.text else {
            throw InputCardViewValidationError.missingFields
        }
        
        guard let logo64Base = logo.toBase64() else {
            fatalError("Corrupted Image")
        }
        
        let lat = "\(location.location.coordinate.latitude)"
        let lon = "\(location.location.coordinate.longitude)"
        
        let form = RegisterationForm.Reseller(enName: name, email: email, password: password, facilityNationalNumber: nationalNumber, telephone: telephone, lat: lat, lng: lon, logoB64: logo64Base, categories:
                                                categories.compactMap { CategoriesIDInput(id:$0.id) }, subcategories: subCategories.compactMap{ SubCategoriesIDInput(id:$0.id) })
        
        return form
    }
    
    func updatePickersState(){
        contentView.categoryView.associatedValue = categories as AnyObject?
        contentView.storeImageView.associatedValue = logoImage
        contentView.licenceView.associatedValue = licenseImage
        contentView.storeLocationView.associatedValue = storeLocation
    }
    
    fileprivate func addValidation(){
        contentView.emailtf.validator = EmailValidatorType()
        contentView.nationalNumbertf.validator = MaxCharactersValidatorType(maxCharactersCount: 100, fieldName: "Facility national number")
    }
    
    fileprivate func connectActions(){
        contentView.storeLocationView.onTap = { [unowned self] in
            let locationPicker = LocationPickerController(title: "Company Location",
                                                          location: self.storeLocation,
                                                          delegate: self)
            locationPicker.present(on: self)
        }
        
        contentView.storeImageView.onTap = { [unowned self] in
            self.imagePickMode = .logo
            let imagePicker = ImagePickerController(presentationController: self,
                                                    delegate: self)
            imagePicker.present(from: contentView.storeImageView)
        }
        
        contentView.licenceView.onTap = { [unowned self] in
            self.imagePickMode = .license
            let imagePicker = ImagePickerController(presentationController: self,
                                                    delegate: self)
            imagePicker.present(from: contentView.licenceView)
        }
        
        self.bottomNextView.nextButton.add(event: .touchUpInside) { [unowned self] in
            do {
                let form = try self.verifyContent()
                self.delegate?.resellerSignUpViewController(sender: self, didFinishWith: form)
            } catch {
                self.showMessage(message: "Please fill all fields", messageType: .failure)
            }
        }
    }
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.scrollView.contentInset.bottom = bottomNextView.bounds.height + 15
    }
}

extension ResellerSignUpViewController: ImagePickerControllerDelegate {
    func imagePickerController(_ sender: ImagePickerController, didFinishWith image: UIImage?) {
        guard let image = image else {
            return
        }
        
        switch imagePickMode {
        case .logo:
            self.logoImage = image
        case .license:
            self.licenseImage = image
        }
    }
}

extension ResellerSignUpViewController: LocationPickerControllerDelegate {
    func locationPickerController(_ sender: LocationPickerController, didFinishWith location: PickedLocation?) {
        self.storeLocation = location
    }
}
