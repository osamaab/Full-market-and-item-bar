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
    func companySignUpViewController(_ sender: CompanySignUpViewController, didFinishWith company: Company)
}

class CompanySignUpViewController: UIViewController {
    
    enum ImagePickMode: Int {
        case logo
        case license
    }
    
    fileprivate lazy var scrollView: ScrollContainerView = .init(contentView: contentView)
    fileprivate lazy var contentView = CompanySignupContentView()
    fileprivate lazy var bottomNextView: BottomNextButtonView = .init(title: "Save")
    
    
    fileprivate var chooseCategoriesCoordinator: SubCategoriesPickerCoordinator?
    fileprivate var imagePickMode: ImagePickMode = .logo
    
    let router: UnownedRouter<AuthenticationRoute>
    
    weak var delegate: CompanySignUpViewControllerDelegate?
    
    var categories: [SubCategory]? {
        didSet {
            updatePickersState()
        }
    }
    
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
    
    var companyLocation: Location? {
        didSet {
            updatePickersState()
        }
    }
    
    init(preferredCategories: [SubCategory]? = nil, router: UnownedRouter<AuthenticationRoute>){
        self.router = router
        self.categories = preferredCategories
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        addValidation()
        connectActions()
        updatePickersState()
    }
    
    fileprivate func setupViews(){
        navigationItem.title = "Company Signup"
        
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            scrollView
            bottomNextView
        }
        
        scrollView.Top == view.safeAreaLayoutGuide.Top + 20
        scrollView.leading(20).trailing(20).bottom(0)
        
        bottomNextView.leading(0).trailing(0).bottom(0)
    }
    
    fileprivate func addValidation(){
        contentView.companytf.validator = MaxCharactersValidatorType(maxCharactersCount: 100, fieldName: "Company name")
        contentView.emailtf.validator = EmailValidatorType()
        contentView.nationalNumbertf.validator = MaxCharactersValidatorType(maxCharactersCount: 100, fieldName: "Facility national number")
        contentView.telephonetf.validator = MaxCharactersValidatorType(maxCharactersCount: 35, fieldName: "Telephone number")
    }
    
    fileprivate func connectActions(){
        // connecting actions
        contentView.categoryView.onTap = { [unowned self] in
            self.router.trigger(.chooseCategories(.company, self))
        }
        
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
            guard let categories = self.categories,
                  let logo = self.logoImage,
                  let license = self.licenseImage,
                  let location = self.companyLocation else {
                return
            }
            
            guard let companyTF = self.contentView.companytf.text,
                  let email = self.contentView.emailtf.text,
                  let password = self.contentView.passwordtf.text,
                  let nationalNumber = self.contentView.nationalNumbertf.text,
                  let telephone = self.contentView.telephonetf.text else {
                return
            }
            
            guard let logo64Base = logo.toBase64() else {
                fatalError("Corrupted Image")
            }
            
            let lat = "\(location.location.coordinate.latitude)"
            let lon = "\(location.location.coordinate.longitude)"
            
            let form = RegisterationForm.Company(enTitle: companyTF, email: email, password: password, national_number: nationalNumber, telephone: telephone, logo_b64: logo64Base, lat: lat, lng: lon, categories: categories.compactMap { RegisterationForm.Category(id: $0.id).parameters })
            let route = AuthenticationAPI.companyRegister(form)
            
            
            
            self.performTask(taskOperation: route.request(Company.self)).then { [unowned self] in
                self.delegate?.companySignUpViewController(self, didFinishWith: $0)
            }
        }
    }
    
    fileprivate func updatePickersState(){
        contentView.categoryView.associatedValue = categories as AnyObject?
        contentView.companyLogoView.associatedValue = logoImage
        contentView.comLicenceView.associatedValue = licenseImage
        contentView.companyLocationView.associatedValue = companyLocation
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.scrollView.contentInset.bottom = bottomNextView.bounds.height + 15
    }
}


extension CompanySignUpViewController: SubCategoriesPickerCoordinatorDelegate {
    func subCategoriesPickerCoordinator(_ sender: SubCategoriesPickerCoordinator, didFinishWith categories: [SubCategory]) {
        self.categories = categories
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
