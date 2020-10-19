//
//  SignUpWizardViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/7/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import LanguageManager_iOS

class SignUpWizardViewController: UIViewController, UITextFieldDelegate {
    
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

        signUpView.backButton.addTarget(self, action: #selector(backButton), for: .touchUpInside)
        signUpView.passwordtf.delegate = self
        signUpView.companytf.delegate = self
        signUpView.emailtf.delegate = self
        signUpView.nationalNumbertf.delegate = self
        signUpView.telephonetf.delegate = self
        
        signUpView.nextButton.addTarget(self, action: #selector(showCategories), for: .touchUpInside)
        
    }
    
    @objc func backButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func showCategories(){
        let vc = SignUpCategoriesListViewController()
        vc.chosenUserType = self.chosenUserType!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        signUpView.companytf.showErrorMessage(message: "")
        signUpView.emailtf.showErrorMessage(message: "")
        signUpView.nationalNumbertf.showErrorMessage(message: "")
        signUpView.telephonetf.showErrorMessage(message: "")
        
        if textField == signUpView.passwordtf{
            showPasswordStrength(for: textField.text ?? "")
            
        }
        
        if textField == signUpView.companytf{
            if textField.text!.count > 100{
                
                signUpView.companytf.showErrorMessage(message: "Company name should be 100 character maximum".localiz())
            }
        }
        
        if textField == signUpView.emailtf{
            if !(isValidEmail(textField.text!)) || textField.text!.count > 50{
                signUpView.emailtf.showErrorMessage(message: "Email is not valid".localiz())
            }
        }
        
        if textField == signUpView.nationalNumbertf{
            if textField.text!.count > 100{
                
                signUpView.nationalNumbertf.showErrorMessage(message: "Facility national number should be 100 character maximum".localiz())
            }
        }
        
        if textField == signUpView.telephonetf{
            if textField.text!.count > 25{
                
                signUpView.telephonetf.showErrorMessage(message: "Telephone number should be 25 character maximum".localiz())
            }
        }
        
        return true
    }
    
    func showPasswordStrength(for text:String)
    {
        
        let strongPassword = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
        if strongPassword.evaluate(with: text){
            signUpView.passwordtf.showPasswordStrengthMessage(type: .Strong)
            return
        }
        
        let mediumPasswod = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        if mediumPasswod.evaluate(with: text){
            signUpView.passwordtf.showPasswordStrengthMessage(type: .Medium)
            return
        }
        
        signUpView.passwordtf.showPasswordStrengthMessage(type: .Weak)
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    



}
