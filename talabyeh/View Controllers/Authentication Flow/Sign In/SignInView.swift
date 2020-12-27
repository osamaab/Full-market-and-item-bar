//
//  SignInView.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import LanguageManager_iOS
import Stevia

class SignInView: UIView {


    let backButton = UIButton()
    let signInLabel = UILabel()
    let welcomeLabel = UILabel()
    let getStartedLabel = UILabel()
    
    let emailtf = BorderedTextField()
    let passwordtf = BorderedTextField()
    
    let signInButton = UIButton()
    
    convenience init() {
        
        self.init(frame:CGRect.zero)
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        defaultLayout()

    }
    
    final private func defaultLayout(){
        
        subviews(backButton)
        subviews(signInLabel)
        subviews(welcomeLabel)
        subviews(getStartedLabel)
        subviews(emailtf)
        subviews(passwordtf)
        subviews(signInButton)
        
        
        self.semanticContentAttribute = LanguageManager.shared.currentLanguage == .ar ? .forceRightToLeft : .forceLeftToRight
        
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.tintColor = DefaultColorsProvider.backgroundPrimary
        
        if LanguageManager.shared.currentLanguage == .ar{
            backButton.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        
        backButton.leading(16)/*.top(30)*/.height(13).width(22)
        backButton.Top == self.safeAreaLayoutGuide.Top + 22

        
        signInLabel.text = "Sign In".localiz()
        signInLabel.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(17, .regular) : getEnglishFont(17, .medium)
        signInLabel.textColor = DefaultColorsProvider.textSecondary2
        signInLabel.textAlignment = .center
        
        signInLabel/*.top(30)*/.height(40).centerHorizontally()
        signInLabel.CenterY == backButton.CenterY
        
        welcomeLabel.text = "Welcome to TALABYEH".localiz()
        welcomeLabel.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(22, .bold) : getEnglishFont(22, .bold)
        welcomeLabel.textColor = DefaultColorsProvider.tintPrimary
        welcomeLabel.textAlignment = .justified
        
        welcomeLabel.height(26).leading(16)
        welcomeLabel.Top == signInLabel.Bottom + 43
        
        getStartedLabel.text = "Let's get started".localiz()
        getStartedLabel.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(17, .regular) : getEnglishFont(17, .medium)
        getStartedLabel.textColor = DefaultColorsProvider.textSecondary2
        getStartedLabel.textAlignment = .justified
        
        getStartedLabel.height(26).leading(16)
        getStartedLabel.Top == welcomeLabel.Bottom + 2
        
        emailtf.placeholder = "Email".localiz()
        emailtf.borderWidth = 0.5
        emailtf.borderColor = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        emailtf.cornerRadius = 10
        emailtf.paddingValue = 16
        emailtf.textAlignment =  LanguageManager.shared.currentLanguage == .ar ? .right : .left
        emailtf.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(16, .regular) : getEnglishFont(16, .medium)
        
        passwordtf.placeholder = "Password".localiz()
        passwordtf.borderWidth = 0.5
        passwordtf.borderColor = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        passwordtf.cornerRadius = 10
        passwordtf.paddingValue = 16
        passwordtf.textAlignment =  LanguageManager.shared.currentLanguage == .ar ? .right : .left
        passwordtf.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(16, .regular) : getEnglishFont(16, .medium)
        
        
        emailtf.leading(16).trailing(16).height(44)
        emailtf.Top == getStartedLabel.Bottom + 33
        
        passwordtf.leading(16).trailing(16).height(44)
        passwordtf.Top == emailtf.Bottom + 16
        
        signInButton.setImage(UIImage(named: "Group 2708"), for: .normal)
        if LanguageManager.shared.currentLanguage == .ar{
            signInButton.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        
        signInButton.width(44).height(44).trailing(16)
        signInButton.Top == passwordtf.Bottom + 73
        
        
    }

}
