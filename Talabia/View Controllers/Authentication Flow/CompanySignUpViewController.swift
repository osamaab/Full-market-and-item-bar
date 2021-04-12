//
//  SignUpWizardViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/7/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia
import XCoordinator

protocol CompanySignUpViewControllerDelegate: class {
    func companySignUpViewController(_ sender: CompanySignUpViewController, didFinishWith company: RegisterationForm.Company)
}

class CompanySignUpViewController: UIViewController {
    
    enum ImagePickMode: Int {
        case logo
        case license
    }
    
    lazy var scrollView: ScrollContainerView = .init(contentView: contentView)
    lazy var contentView = CompanySignupContentView()
    lazy var bottomNextView: BottomNextButtonView = .init(title: "Save")
    
    fileprivate var chooseCategoriesCoordinator: SubCategoriesPickerCoordinator?
    fileprivate var imagePickMode: ImagePickMode = .logo
        
    weak var delegate: CompanySignUpViewControllerDelegate?
    
    var validation = Validation()
    
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
    
    var companyLocation: Location? {
        didSet {
            updatePickersState()
        }
    }
    
    init(categories: [MainCategory],subCategories: [SubCategory]){
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
    
    func verifyContent() throws -> RegisterationForm.Company {
        guard let companyTF = self.contentView.companytf.text,
              let email = self.contentView.emailtf.text,
              let password = self.contentView.passwordtf.text,
              let nationalNumber = self.contentView.nationalNumbertf.text,
              let telephone = self.contentView.telephonetf.text else {
            throw InputCardViewValidationError.missingFields
        }
       
        guard let license = self.licenseImage,
              let location = self.companyLocation
        else
        {
            throw InputCardViewValidationError.missingFields
        }
        guard let logo = self.logoImage else {
            throw InputCardViewValidationError.missingFields
        }
        contentView.worningImageView.removeFromSuperview()
        guard let logo64Base = logo.toBase64() else {
            fatalError("Corrupted Image")
        }
        
        let lat = "\(location.location.coordinate.latitude)"
        let lon = "\(location.location.coordinate.longitude)"
        
        let form = RegisterationForm.Company(enTitle: companyTF, email: email, password: password, nationalNumber: nationalNumber, telephone: telephone, lat: lat, lng:lon, logoB64: logo64Base, categories:
                                                categories.compactMap { CategoriesIDInput(id:$0.id) }, subcategories: subCategories.compactMap{ SubCategoriesIDInput(id:$0.id) })

        return form
    }
    
    func updatePickersState(){
        contentView.categoryView.associatedValue = categories as AnyObject?
        contentView.companyLogoView.associatedValue = logoImage
        contentView.comLicenceView.associatedValue = licenseImage
        contentView.companyLocationView.associatedValue = companyLocation
    }
    
    fileprivate func addValidation(){
//        contentView.companytf.validator = MaxCharactersValidatorType(maxCharactersCount: 100, fieldName: "Company name")
        contentView.emailtf.validator = EmailValidatorType()
        contentView.nationalNumbertf.validator = MaxCharactersValidatorType(maxCharactersCount: 100, fieldName: "Facility national number")
//        contentView.telephonetf.validator = MaxCharactersValidatorType(maxCharactersCount: 35, fieldName: "Telephone number")
    }
    
    fileprivate func connectActions(){
        contentView.companyLocationView.onTap = { [unowned self] in
            let locationPicker = LocationPickerController(title: "Company Location",
                                                          location: self.companyLocation,
                                                          delegate: self)
            locationPicker.present(on: self)
        }
        
        contentView.companyLogoView.onTap = { [unowned self] in
            self.imagePickMode = .logo
            let imagePicker = ImagePickerController(presentationController: self,
                                                    delegate: self)
            imagePicker.present(from: contentView.companyLogoView)
        }
        
        contentView.comLicenceView.onTap = { [unowned self] in
            self.imagePickMode = .license
            let imagePicker = ImagePickerController(presentationController: self,
                                                    delegate: self)
            imagePicker.present(from: contentView.comLicenceView)
        }
        
        self.bottomNextView.nextButton.add(event: .touchUpInside) { [unowned self] in
            
            do {
                let form = try self.verifyContent()
                self.delegate?.companySignUpViewController(self, didFinishWith: form)
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

extension CompanySignUpViewController: ImagePickerControllerDelegate {
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

extension CompanySignUpViewController: LocationPickerControllerDelegate {
    func locationPickerController(_ sender: LocationPickerController, didFinishWith location: PickedLocation?) {
        self.companyLocation = location
    }
}
