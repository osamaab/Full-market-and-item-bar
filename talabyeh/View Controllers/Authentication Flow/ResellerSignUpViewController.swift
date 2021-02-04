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
    func resellerSignUpViewController(sender: ResellerSignUpViewController, didFinishWith reseller: Reseller)
}

class ResellerSignUpViewController: UIViewController {
    
    enum ImagePickMode: Int {
        case logo
        case license
    }
    
    fileprivate lazy var scrollView: ScrollContainerView = .init(contentView: contentView)
    fileprivate lazy var contentView = ResellerSignUpContentView()
    fileprivate lazy var bottomNextView: BottomNextButtonView = .init(title: "Save")
    
    
    fileprivate var chooseCategoriesCoordinator: SubCategoriesPickerCoordinator?
    fileprivate var imagePickMode: ImagePickMode = .logo
    
    let router: UnownedRouter<AuthenticationRoute>
    
    weak var delegate: ResellerSignUpViewControllerDelegate?
    
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
    
    var storeLocation: Location? {
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
        navigationItem.title = "Reseller Signup"
        
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
        contentView.nametf.validator = MaxCharactersValidatorType(maxCharactersCount: 100, fieldName: "Reseller's name")
        contentView.emailtf.validator = EmailValidatorType()
        contentView.nationalNumbertf.validator = MaxCharactersValidatorType(maxCharactersCount: 100, fieldName: "Facility national number")
        contentView.telephonetf.validator = MaxCharactersValidatorType(maxCharactersCount: 35, fieldName: "Telephone number")
    }
    
    fileprivate func connectActions(){
        // connecting actions
        contentView.categoryView.onTap = { [unowned self] in
            self.router.trigger(.chooseCategories(.company, self))
        }
        
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
            guard let categories = self.categories,
                  let logo = self.logoImage,
                  let license = self.licenseImage,
                  let location = self.storeLocation else {
                return
            }
            
            guard let name = self.contentView.nametf.text,
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
            
            let form = RegisterationForm.Reseller(en_name: name, email: email, password: password, national_number: nationalNumber, telephone: telephone, picture: logo64Base, lat: lat, lng: lon, categories: categories.compactMap { RegisterationForm.Category(id: $0.id).parameters })
            
            self.performTask(taskOperation: AuthenticationAPI.resellerRegister(form).request(Reseller.self)).then {
                self.delegate?.resellerSignUpViewController(sender: self, didFinishWith: $0)
            }
        }
    }
    
    fileprivate func updatePickersState(){
        contentView.categoryView.associatedValue = categories as AnyObject?
        contentView.storeImageView.associatedValue = logoImage
        contentView.licenceView.associatedValue = licenseImage
        contentView.storeLocationView.associatedValue = storeLocation
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.scrollView.contentInset.bottom = bottomNextView.bounds.height + 15
    }
}

extension ResellerSignUpViewController: SubCategoriesPickerCoordinatorDelegate {
    func subCategoriesPickerCoordinator(_ sender: SubCategoriesPickerCoordinator, didFinishWith categories: [SubCategory]) {
        self.categories = categories
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
