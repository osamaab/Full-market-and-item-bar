//
//  DistributorSignUpViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/21/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

extension CarType: ChoiceItemType {
    var id: String {
        "\(carID)"
    }
}


protocol DistributorSignUpViewControllerDelegate: class {
    func distributorSignUpViewController(_ sender: DistributorSignUpViewController, didFinishWith distributor: RegisterationForm.Distributor)
}

/**
 A Distributor Signup is defined as a ContentViewController so it can take full advantage of lifecycle of loading data, as we need to load the car types.
 */
class DistributorSignUpViewController: ContentViewController<[CarType]> {
    
    enum ImagePickMode: Int {
        case logo
        case license
    }
    
    lazy var scrollView: ScrollContainerView = .init(contentView: contentView)
    lazy var contentView = DistributorSignUpContentView()
    lazy var bottomNextView: BottomNextButtonView = .init(title: "Save")
    
    fileprivate var imagePickMode: ImagePickMode = .logo
    
    weak var delegate: DistributorSignUpViewControllerDelegate?
    
    fileprivate var pickedCarImage: UIImage? {
        didSet {
            updatePickersState()
        }
    }
    
    fileprivate var pickedCarLicense: UIImage? {
        didSet {
            updatePickersState()
        }
    }
    
    convenience init(){
        self.init(contentRepository: APIContentRepositoryType<AuthenticationAPI, [CarType]>(.carTypes))
    }

    override func setupViewsBeforeTransitioning() {
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            scrollView
            bottomNextView
        }
        
        scrollView.Top == view.safeAreaLayoutGuide.Top + 20
        scrollView.leading(20).trailing(20).bottom(0)
        
        bottomNextView.leading(0).trailing(0).bottom(0)
        
        // adding validation
        contentView.firstNametf.validator = MaxCharactersValidatorType(maxCharactersCount: 100, fieldName: "Distributor Name")
        contentView.emailtf.validator = EmailValidatorType()
        
        connectActions()
    }
    
    fileprivate func connectActions(){
        contentView.personalPictureView.onTap = { [unowned self] in
            self.imagePickMode = .logo
            let imagePicker = ImagePickerController(presentationController: self,
                                                    delegate: self)
            imagePicker.present(from: contentView.personalPictureView)
        }
        
        contentView.civilIDPictureView.onTap = { [unowned self] in
            self.imagePickMode = .license
            let imagePicker = ImagePickerController(presentationController: self,
                                                    delegate: self)
            imagePicker.present(from: contentView.civilIDPictureView)
        }
        
        
        bottomNextView.nextButton.add(event: .touchUpInside){ [unowned self] in
            guard let name = self.contentView.firstNametf.text,
                  let password = self.contentView.passwordtf.text,
                  let email = self.contentView.emailtf.text,
                  let nationalNumber = self.contentView.nationalNumbertf.text,
                  let mobile = self.contentView.mobileNumbertf.text,
                  let carType = self.contentView.carType.selectedItem else {
                self.showMessage(message: "Please fill All Fields", messageType: .failure)
                return
            }
            
            guard let logoImage = self.pickedCarImage,
                  let licenseImage = self.pickedCarLicense else {
                return
            }
            
            let form = RegisterationForm.Distributor(en_name: name,
                                                     email: email,
                                                     password: password,
                                                     dist_type_id: 1,
                                                     national_number: nationalNumber,
                                                     mobile: mobile,
                                                     personal_picture_b64: logoImage.toBase64()!,
                                                     car_type_id: carType.carID)
            
            self.delegate?.distributorSignUpViewController(self, didFinishWith: form)
        }
    }
    
    fileprivate func updatePickersState(){
        contentView.personalPictureView.associatedValue = pickedCarImage
        contentView.civilIDPictureView.associatedValue = pickedCarLicense
    }
    
    
    override func contentRequestDidSuccess(with content: [CarType]) {
        self.contentView.carType.choices = content
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.scrollView.contentInset.bottom = bottomNextView.bounds.height + 15
    }
}

extension DistributorSignUpViewController: ImagePickerControllerDelegate {
    func imagePickerController(_ sender: ImagePickerController, didFinishWith image: UIImage?) {
        guard let image = image else {
            return
        }
        
        switch imagePickMode {
        case .logo:
            self.pickedCarImage = image
        case .license:
            self.pickedCarLicense = image
        }
    }
}
