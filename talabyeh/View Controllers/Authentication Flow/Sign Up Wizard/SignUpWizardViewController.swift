//
//  SignUpWizardViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/7/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import LanguageManager_iOS


class SignUpWizardViewController: UIViewController {
    
    let signUpView = SignUpWizardView()
    
    var chosenUserType: UserTypeEnum?
    
    override func loadView() {
        view = signUpView
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        switch chosenUserType! {
        case .Company:
            signUpView.merchantTypeImage.image = LanguageManager.shared.currentLanguage == .en ? UIImage(named: "CompanyImageEnglish") : UIImage(named: "CompanyImageArabic")
        case .Distributor:
            signUpView.merchantTypeImage.image = LanguageManager.shared.currentLanguage == .en ? UIImage(named: "DistributorImageEnglish") : UIImage(named: "DistributorImageArabic")
        case .Reseller:
            signUpView.merchantTypeImage.image = LanguageManager.shared.currentLanguage == .en ? UIImage(named: "ResellerImageEnglish") : UIImage(named: "ResellerImageArabic")
        }
        
        
        // setting up validation :))
        
        signUpView.companytf.validator = MaxCharactersValidatorType(maxCharactersCount: 100, fieldName: "Company name")
        signUpView.emailtf.validator = EmailValidatorType()
        signUpView.nationalNumbertf.validator = MaxCharactersValidatorType(maxCharactersCount: 100, fieldName: "Facility national number")
        signUpView.telephonetf.validator = MaxCharactersValidatorType(maxCharactersCount: 35, fieldName: "Telephone number")
        
        signUpView.backButton.addTarget(self, action: #selector(backButton), for: .touchUpInside)
        signUpView.nextButton.addTarget(self, action: #selector(showCategories), for: .touchUpInside)
        
        signUpView.companyLocationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(locationViewTapped)))
    }
    
    @objc func locationViewTapped(){
        LocationPickerController(title: "Store Locator", location: nil, delegate: self).present(on: self)
    }
    
    @objc func backButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func showCategories(){
        let vc = SignUpCategoriesListViewController()
        vc.chosenUserType = self.chosenUserType!
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SignUpWizardViewController: LocationPickerControllerDelegate {
    func locationPickerController(_ sender: LocationPickerController, didFinishWith location: PickedLocation?) {
        print("finished")
    }
}
