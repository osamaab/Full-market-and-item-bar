//
//  SignUpWizardView.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/7/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia
import LanguageManager_iOS
import ValidationTextField

class SignUpWizardView: UIView, UITableViewDelegate, UITableViewDataSource {

    

    let backButton = UIButton(/*frame: CGRect(x: 20, y: 42.5, width: 50, height: 50)*/)
    let signUpLabel = UILabel(/*frame: CGRect(x: 166.5, y: 44, width: 120, height: 47)*/)
    let welcomeLabel = UILabel()
    let merchantTypeImage = UIImageView()
    
    
    let companytf = ValidationTextField()
    let passwordtf = PasswordTextField()
    let emailtf = ValidationTextField()
    let nationalNumbertf = ValidationTextField()
    let telephonetf = ValidationTextField()
    
    
    let comLicenceView = UIView()
    let companyLogoView = UIView()
    let companyLocationView = UIView()
    let categoryView = UIView()
    
    let bottomView = UIView()
    let nextButton = UIButton()
    
    let contentTableView = UITableView()
    let contentTableViewCell = UITableViewCell()
    
    let commercialLicenceButton = UIButton()
    let companyLogoButton = UIButton()
    let companyLocationButton = UIButton()
    let categoryButton = UIButton()
    
    
    convenience init() {
        
        self.init(frame:CGRect.zero)
        backgroundColor = DefaultColorsProvider.background
        
        defaultLayout()

    }
    
    
    final private func defaultLayout(){

        subviews(backButton)
        subviews(signUpLabel)
        subviews(contentTableView)
        
        contentTableViewCell.subviews(welcomeLabel)
        contentTableViewCell.subviews(merchantTypeImage)
        contentTableViewCell.subviews(companytf)
        contentTableViewCell.subviews(passwordtf)
        contentTableViewCell.subviews(emailtf)
        contentTableViewCell.subviews(nationalNumbertf)
        contentTableViewCell.subviews(telephonetf)
        contentTableViewCell.subviews(comLicenceView)
        contentTableViewCell.subviews(companyLogoView)
        contentTableViewCell.subviews(companyLocationView)
        contentTableViewCell.subviews(categoryView)
        
        subviews(bottomView)
        
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.separatorStyle = .none
        contentTableView.allowsSelection = false
        
        contentTableView.leading(0).trailing(0).height(900)
        contentTableView.Top == signUpLabel.Bottom + 8

        
        self.semanticContentAttribute = LanguageManager.shared.currentLanguage == .ar ? .forceRightToLeft : .forceLeftToRight
        
        backButton.setImage(UIImage(named: "back"), for: .normal)
        
        if LanguageManager.shared.currentLanguage == .ar{
            backButton.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        
        backButton.leading(16)/*.top(30)*/.height(13).width(22)
        backButton.Top == self.safeAreaLayoutGuide.Top + 22

        
        signUpLabel.text = "Sign Up".localiz()
        signUpLabel.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(17, .regular) : getEnglishFont(17, .medium)
        signUpLabel.textColor = DefaultColorsProvider.itemBackground2
        signUpLabel.textAlignment = .center
        
        signUpLabel/*.top(30)*/.height(40).centerHorizontally()
        //signUpLabel.Top == self.safeAreaLayoutGuide.Top + 22
        signUpLabel.CenterY == backButton.CenterY
        
        welcomeLabel.text = "Welcome to TALABYEH".localiz()
        welcomeLabel.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(22, .bold) : getEnglishFont(22, .bold)
        welcomeLabel.textColor = DefaultColorsProvider.darkerTint
        welcomeLabel.textAlignment = .justified
        
        welcomeLabel.height(26).leading(16).top(0)
        //welcomeLabel.Top == signUpLabel.Bottom + 10
        
        merchantTypeImage.image = UIImage(named: "Group 2709")
        merchantTypeImage.image = merchantTypeImage.image?.withRenderingMode(.alwaysTemplate)
        merchantTypeImage.tintColor = DefaultColorsProvider.darkerTint
        merchantTypeImage.leading(16).trailing(16).height(33)
        merchantTypeImage.Top == welcomeLabel.Bottom + 9
        

        companytf.placeholder = "Company Name".localiz()
        companytf.borderWidth = 0.5
        companytf.borderColor = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        companytf.cornerRadius = 10
        companytf.paddingValue = 16
        companytf.textAlignment =  LanguageManager.shared.currentLanguage == .ar ? .right : .left
        companytf.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(16, .regular) : getEnglishFont(16, .medium)
        
        passwordtf.placeholder = "Password".localiz()
        passwordtf.borderWidth = 0.5
        passwordtf.borderColor = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        passwordtf.cornerRadius = 10
        passwordtf.paddingValue = 16
        passwordtf.textAlignment =  LanguageManager.shared.currentLanguage == .ar ? .right : .left
        passwordtf.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(16, .regular) : getEnglishFont(16, .medium)
        
        emailtf.placeholder = "Email".localiz()
        emailtf.borderWidth = 0.5
        emailtf.borderColor = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        emailtf.cornerRadius = 10
        emailtf.paddingValue = 16
        emailtf.textAlignment =  LanguageManager.shared.currentLanguage == .ar ? .right : .left
        emailtf.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(16, .regular) : getEnglishFont(16, .medium)
        
        nationalNumbertf.placeholder = "Facility National Number".localiz()
        nationalNumbertf.borderWidth = 0.5
        nationalNumbertf.borderColor = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        nationalNumbertf.cornerRadius = 10
        nationalNumbertf.paddingValue = 16
        nationalNumbertf.textAlignment =  LanguageManager.shared.currentLanguage == .ar ? .right : .left
        nationalNumbertf.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(16, .regular) : getEnglishFont(16, .medium)
        
        telephonetf.placeholder = "Telephone".localiz()
        telephonetf.borderWidth = 0.5
        telephonetf.borderColor = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        telephonetf.cornerRadius = 10
        telephonetf.paddingValue = 16
        telephonetf.textAlignment =  LanguageManager.shared.currentLanguage == .ar ? .right : .left
        telephonetf.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(16, .regular) : getEnglishFont(16, .medium)
        
        companytf.leading(16).trailing(16).height(44)
        companytf.Top == merchantTypeImage.Bottom + 17
        
        passwordtf.leading(16).trailing(16).height(44)
        passwordtf.Top == companytf.Bottom + 16 + 22
        
        emailtf.leading(16).trailing(16).height(44)
        emailtf.Top == passwordtf.Bottom + 16 + 22
        
        nationalNumbertf.leading(16).trailing(16).height(44)
        nationalNumbertf.Top == emailtf.Bottom + 16 + 22
        
        telephonetf.leading(16).trailing(16).height(44)
        telephonetf.Top == nationalNumbertf.Bottom + 16 + 22
        
        
        // view 1
        let label = UILabel()
        let icon = UIImageView()
        comLicenceView.subviews(label)
        comLicenceView.subviews(icon)
        comLicenceView.subviews(commercialLicenceButton)

        label.text = "Commercial licence".localiz()
        label.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(16, .regular) : getEnglishFont(16, .medium)
        label.textAlignment = .center
        label.bottom(15).width(135).height(19).centerHorizontally()

        icon.image = UIImage(named: "Group 2710")
        icon.top(23).width(28).height(22).centerHorizontally()
        
        comLicenceView.backgroundColor = DefaultColorsProvider.itemBackground2
        comLicenceView.layer.cornerRadius = 10
        comLicenceView.leading(16).width(167).height(91)
        comLicenceView.Top == telephonetf.Bottom + 12 + 22
        
        commercialLicenceButton.fillContainer()
        
        // view 2
        let label2 = UILabel()
        let icon2 = UIImageView()
        companyLogoView.subviews(label2)
        companyLogoView.subviews(icon2)
        companyLogoView.subviews(companyLogoButton)

        label2.text = "Company Logo".localiz()
        label2.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label2.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(16, .regular) : getEnglishFont(16, .medium)
        label2.textAlignment = .center
        label2.bottom(15).width(135).height(19).centerHorizontally()

        icon2.image = UIImage(named: "Group 2710")
        icon2.top(23).width(28).height(22).centerHorizontally()
        
        companyLogoView.backgroundColor = DefaultColorsProvider.itemBackground2
        companyLogoView.layer.cornerRadius = 10
        companyLogoView.trailing(16).width(167).height(91)
        companyLogoView.Top == telephonetf.Bottom + 12  + 22
        
        companyLogoButton.fillContainer()
        
        //view 3
        
        let label3 = UILabel()
        let icon3 = UIImageView()
        companyLocationView.subviews(label3)
        companyLocationView.subviews(icon3)
        companyLogoView.subviews(companyLogoButton)

        label3.text = "Company Location".localiz()
        label3.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label3.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(16, .regular) : getEnglishFont(16, .medium)
        label3.textAlignment = .center
        label3.bottom(15).width(135).height(19).centerHorizontally()

        icon3.image = UIImage(named: "Group 2711")
        icon3.contentMode = .scaleAspectFit
        icon3.top(23).width(28).height(22).centerHorizontally()
        
        companyLocationView.backgroundColor = DefaultColorsProvider.itemBackground2
        companyLocationView.layer.cornerRadius = 10
        companyLocationView.leading(16).width(167).height(91)
        companyLocationView.Top == companyLogoView.Bottom + 10
        
        companyLogoButton.fillContainer()
        
        // view 4
        
        let label4 = UILabel()
        let icon4 = UIImageView()
        categoryView.subviews(label4)
        categoryView.subviews(icon4)
        categoryView.subviews(categoryButton)

        label4.text = "Category".localiz()
        label4.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label4.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(16, .regular) : getEnglishFont(16, .medium)
        label4.textAlignment = .center
        label4.bottom(15).width(135).height(19).centerHorizontally()

        icon4.image = UIImage(named: "Path 2437")
        icon4.top(23).width(28).height(22).centerHorizontally()
        
        categoryView.backgroundColor = DefaultColorsProvider.itemBackground2
        categoryView.layer.cornerRadius = 10
        categoryView.trailing(16).width(167).height(91)
        categoryView.Top == companyLogoView.Bottom + 10
        
        categoryButton.fillContainer()
        
        // Bottom View
        
        bottomView.subviews(nextButton)
        
        //nextButton.backgroundColor = #colorLiteral(red: 0.5764705882, green: 0.8352941176, blue: 0, alpha: 1)
        nextButton.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.3607843137, blue: 0.1960784314, alpha: 1)
        nextButton.layer.borderWidth = 1
        nextButton.top(10).width(250).height(44).centerHorizontally()
        nextButton.setTitleColor(#colorLiteral(red: 0.06666666667, green: 0.3607843137, blue: 0.1960784314, alpha: 1), for: .normal)
        nextButton.setTitle("Next".localiz(), for: .normal)
        nextButton.titleLabel?.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(16, .regular) : getEnglishFont(16, .medium)
        nextButton.layer.cornerRadius = 20
        if LanguageManager.shared.currentLanguage == .ar{
            nextButton.contentVerticalAlignment = .top
        }
        
        bottomView.backgroundColor = #colorLiteral(red: 0.5764705882, green: 0.8352941176, blue: 0, alpha: 1)
        bottomView.leading(0).trailing(0).bottom(0).height(83)
        


        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return contentTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        1100
    }
    
    

}
