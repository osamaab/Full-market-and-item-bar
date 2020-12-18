//
//  DistributorSignUpView.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/21/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia
import LanguageManager_iOS
import ValidationTextField

class DistributorSignUpView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    enum DistributorType{
        case CompanyDistributor
        case PersonalDistributor
    }
    var distributorType : DistributorType?{
        didSet{
            switch self.distributorType{
            case .CompanyDistributor:
                personalDistributorView.isHidden = true
                companyDistributorView.isHidden = false
                self.contentTableView.isScrollEnabled = false
//                self.personalDistributorView.removeFromSuperview()
//                self.contentTableViewCell.subviews(companyDistributorView)
                
                companyDistributorButton.backgroundColor = Constants.lightGreen
                companyDistributorButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                companyDistributorButton.layer.borderWidth = 0
                companyDistributorButton.setTitleColor(Constants.darkGreen, for: .normal)
                personalDistributorButton.backgroundColor = UIColor(named: AdaptiveColors.buttonGrey.rawValue)
                personalDistributorButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                personalDistributorButton.layer.borderWidth = 1
                personalDistributorButton.setTitleColor(.white, for: .normal)
            case .PersonalDistributor:
                companyDistributorView.isHidden = true
                personalDistributorView.isHidden = false
                self.contentTableView.isScrollEnabled = true
//                self.companyDistributorView.removeFromSuperview()
//                self.contentTableViewCell.subviews(personalDistributorView)
                
                personalDistributorButton.backgroundColor = Constants.lightGreen
                personalDistributorButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                personalDistributorButton.layer.borderWidth = 0
                personalDistributorButton.setTitleColor(Constants.darkGreen, for: .normal)
                companyDistributorButton.backgroundColor = UIColor(named: AdaptiveColors.buttonGrey.rawValue)
                companyDistributorButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                companyDistributorButton.layer.borderWidth = 1
                companyDistributorButton.setTitleColor(.white, for: .normal)
            default:
                break
            }
        }
    }

    let backButton = UIButton()
    let signUpLabel = UILabel()
    let welcomeLabel = UILabel()
    let headerImage = UIImageView()
    
    let personalDistributorButton = UIButton()
    let companyDistributorButton = UIButton()
    
    let personalDistributorView = UIView()
    let companyDistributorView = UIView()
    
    let emailtfpersonal = BorderedTextField()
    let passwordtfpersonal = BorderedTextField()
    
    let firstNametf = BorderedTextField()
    let passwordtf = BorderedTextField()
    let emailtf = BorderedTextField()
    let mobileNumbertf = BorderedTextField()
    let carType = BorderedTextField()
    
    
    let personalPictureView = UIView()
    let civilIDPictureView = UIView()
    let coverageLocationsView = UIView()
    let categoryView = UIView()
    
    let bottomView = UIView()
    let nextButton = UIButton()
    
    let contentTableView = UITableView()
    let contentTableViewCell = UITableViewCell()
    
    let personalPictureButton = UIButton()
    let civilIDpictureButton = UIButton()
    let coverageLocationsButton = UIButton()
    let categoryButton = UIButton()
    
    
    convenience init() {
        
        self.init(frame:CGRect.zero)
        backgroundColor = DefaultColorsProvider.background

        defaultLayout()

    }
    
    @objc func changeDistributorTypeSelection(_ sender: UIButton)
    {
        if sender.tag == 1{
            self.distributorType = .CompanyDistributor
        }else if sender.tag == 2{
            self.distributorType = .PersonalDistributor
        }
    }
    
    final private func defaultLayout(){

        subviews(backButton)
        subviews(signUpLabel)
        subviews(welcomeLabel)
        subviews(headerImage)
        subviews(personalDistributorButton)
        subviews(companyDistributorButton)
        subviews(contentTableView)
        subviews(bottomView)
        
        //contentTableViewCell.subviews(companyDistributorView)
        contentTableViewCell.subviews(personalDistributorView)
        contentTableViewCell.subviews(companyDistributorView)

        personalDistributorView.subviews(firstNametf)
        personalDistributorView.subviews(passwordtf)
        personalDistributorView.subviews(emailtf)
        personalDistributorView.subviews(mobileNumbertf)
        personalDistributorView.subviews(carType)
        personalDistributorView.subviews(personalPictureView)
        personalDistributorView.subviews(civilIDPictureView)
        personalDistributorView.subviews(coverageLocationsView)
        personalDistributorView.subviews(categoryView)
        
        companyDistributorView.subviews(emailtfpersonal)
        companyDistributorView.subviews(passwordtfpersonal)

        
        self.semanticContentAttribute = LanguageManager.shared.currentLanguage == .ar ? .forceRightToLeft : .forceLeftToRight
        
        
        backButton.setImage(UIImage(named: "back"), for: .normal)
        
        if LanguageManager.shared.currentLanguage == .ar{
            backButton.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        
        backButton.leading(16)/*.top(30)*/.height(13.66).width(22.02)
        backButton.Top == self.safeAreaLayoutGuide.Top + 22

        
        signUpLabel.text = "Sign Up".localiz()
        signUpLabel.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(17, .regular) : getEnglishFont(17, .medium)
        signUpLabel.textColor = UIColor(named: AdaptiveColors.darkGrey.rawValue)
        signUpLabel.textAlignment = .center
        
        signUpLabel/*.top(30)*/.height(40).centerHorizontally()
        //signUpLabel.Top == self.safeAreaLayoutGuide.Top + 22
        signUpLabel.CenterY == backButton.CenterY
        
        welcomeLabel.text = "Welcome to TALABYEH".localiz()
        welcomeLabel.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(22, .bold) : getEnglishFont(22, .bold)
        welcomeLabel.textColor = UIColor(named: AdaptiveColors.green.rawValue)
        welcomeLabel.textAlignment = .justified
        
        welcomeLabel.height(26).leading(16)
        welcomeLabel.Top == signUpLabel.Bottom + 17.59
        
        headerImage.image = UIImage(named: "Group 2709")
        headerImage.leading(16).trailing(16).height(33)
        headerImage.Top == welcomeLabel.Bottom + 9
        
        companyDistributorButton.setTitle("Company\nDistributor".localiz(), for: .normal)
        companyDistributorButton.layer.cornerRadius = 10
        companyDistributorButton.layer.borderWidth = 1
        companyDistributorButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        companyDistributorButton.backgroundColor = UIColor(named: AdaptiveColors.buttonGrey.rawValue)
        companyDistributorButton.setTitleColor(UIColor(named: AdaptiveColors.green.rawValue), for: .normal)
        companyDistributorButton.titleLabel?.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(17, .heavy) : getEnglishFont(17, .semiBold)
        //companyDistributorButton.titleLabel?.numberOfLines = 2
        companyDistributorButton.titleLabel?.lineBreakMode = .byWordWrapping
        companyDistributorButton.tag = 1
        companyDistributorButton.addTarget(self, action: #selector(changeDistributorTypeSelection(_:)), for: .touchUpInside)
        

        companyDistributorButton.leading(16).height(50)//.width(169)
        companyDistributorButton.Trailing == self.CenterX - 2.5
        companyDistributorButton.Top == headerImage.Bottom + 14
        
        personalDistributorButton.setTitle("Personal\nDistributor".localiz(), for: .normal)
        personalDistributorButton.layer.cornerRadius = 10
        personalDistributorButton.backgroundColor = UIColor(named: AdaptiveColors.buttonGrey.rawValue)
        personalDistributorButton.setTitleColor(Constants.darkGreen, for: .normal)
        personalDistributorButton.titleLabel?.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(17, .heavy) : getEnglishFont(17, .semiBold)
        //personalDistributorButton.titleLabel?.numberOfLines = 2
        personalDistributorButton.titleLabel?.lineBreakMode = .byWordWrapping
        personalDistributorButton.tag = 2
        personalDistributorButton.addTarget(self, action: #selector(changeDistributorTypeSelection(_:)), for: .touchUpInside)

        personalDistributorButton.trailing(16).height(50)//.width(169)
        personalDistributorButton.Leading == self.CenterX + 2.5
        personalDistributorButton.CenterY == companyDistributorButton.CenterY
        
        
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.separatorStyle = .none
        contentTableView.allowsSelection = false
        
        contentTableView.leading(0).trailing(0).height(900)
        contentTableView.Top == companyDistributorButton.Bottom + 14
        
        personalDistributorView.leading(0).trailing(0).top(0)
        personalDistributorView.Height == contentTableViewCell.Height
        
        companyDistributorView.leading(0).trailing(0).top(0)
        companyDistributorView.Height == contentTableViewCell.Height
        
        // Company Distributor View
        emailtfpersonal.placeholder = "Email".localiz()
        emailtfpersonal.borderWidth = 0.5
        emailtfpersonal.borderColor = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        emailtfpersonal.cornerRadius = 10
        emailtfpersonal.paddingValue = 16
        emailtfpersonal.textAlignment =  LanguageManager.shared.currentLanguage == .ar ? .right : .left
        emailtfpersonal.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(16, .regular) : getEnglishFont(16, .medium)
        
        passwordtfpersonal.placeholder = "Password".localiz()
        passwordtfpersonal.borderWidth = 0.5
        passwordtfpersonal.borderColor = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        passwordtfpersonal.cornerRadius = 10
        passwordtfpersonal.paddingValue = 16
        passwordtfpersonal.textAlignment =  LanguageManager.shared.currentLanguage == .ar ? .right : .left
        passwordtfpersonal.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(16, .regular) : getEnglishFont(16, .medium)
        
        emailtfpersonal.leading(16).trailing(16).height(44).top(10)
        
        passwordtfpersonal.leading(16).trailing(16).height(44)
        passwordtfpersonal.Top == emailtfpersonal.Bottom + 16 + 22
        

        //
        
        
        firstNametf.placeholder = "Company Name".localiz()
        firstNametf.borderWidth = 0.5
        firstNametf.borderColor = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        firstNametf.cornerRadius = 10
        firstNametf.paddingValue = 16
        firstNametf.textAlignment =  LanguageManager.shared.currentLanguage == .ar ? .right : .left
        firstNametf.font = .font(for: .regular, size: 16)
        
        passwordtf.placeholder = "Password".localiz()
        passwordtf.borderWidth = 0.5
        passwordtf.borderColor = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        passwordtf.cornerRadius = 10
        passwordtf.paddingValue = 16
        passwordtf.textAlignment =  LanguageManager.shared.currentLanguage == .ar ? .right : .left
        passwordtf.font = .font(for: .regular, size: 16)
        
        emailtf.placeholder = "Email".localiz()
        emailtf.borderWidth = 0.5
        emailtf.borderColor = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        emailtf.cornerRadius = 10
        emailtf.paddingValue = 16
        emailtf.textAlignment =  LanguageManager.shared.currentLanguage == .ar ? .right : .left
        emailtf.font = .font(for: .regular, size: 16)
        
        mobileNumbertf.placeholder = "Facility National Number".localiz()
        mobileNumbertf.borderWidth = 0.5
        mobileNumbertf.borderColor = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        mobileNumbertf.cornerRadius = 10
        mobileNumbertf.paddingValue = 16
        mobileNumbertf.textAlignment =  LanguageManager.shared.currentLanguage == .ar ? .right : .left
        mobileNumbertf.font = .font(for: .regular, size: 16)
        
        carType.placeholder = "Telephone".localiz()
        carType.borderWidth = 0.5
        carType.borderColor = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
        carType.cornerRadius = 10
        carType.paddingValue = 16
        carType.textAlignment =  LanguageManager.shared.currentLanguage == .ar ? .right : .left
        carType.font = .font(for: .regular, size: 16)
        
        firstNametf.leading(16).trailing(16).height(44).top(0)
        //firstNametf.Top == headerImage.Bottom + 17
        
        passwordtf.leading(16).trailing(16).height(44)
        passwordtf.Top == firstNametf.Bottom + 16 + 22
        
        emailtf.leading(16).trailing(16).height(44)
        emailtf.Top == passwordtf.Bottom + 16 + 22
        
        mobileNumbertf.leading(16).trailing(16).height(44)
        mobileNumbertf.Top == emailtf.Bottom + 16 + 22
        
        carType.leading(16).trailing(16).height(44)
        carType.Top == mobileNumbertf.Bottom + 16 + 22
        
        
        // view 1
        let label = UILabel()
        let icon = UIImageView()
        personalPictureView.subviews(label)
        personalPictureView.subviews(icon)
        personalPictureView.subviews(personalPictureButton)

        label.text = "Commercial licence".localiz()
        label.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = .font(for: .regular, size: 16)
        label.textAlignment = .center
        label.bottom(15).width(135).height(19).centerHorizontally()

        icon.image = UIImage(named: "Group 2710")
        icon.top(23).width(28).height(22).centerHorizontally()
        
        personalPictureView.backgroundColor = UIColor(named: AdaptiveColors.buttonGrey.rawValue)
        personalPictureView.layer.cornerRadius = 10
        personalPictureView.leading(16).width(167).height(91)
        personalPictureView.Top == carType.Bottom + 12 + 22
        
        personalPictureButton.fillContainer()
        
        // view 2
        let label2 = UILabel()
        let icon2 = UIImageView()
        civilIDPictureView.subviews(label2)
        civilIDPictureView.subviews(icon2)
        civilIDPictureView.subviews(civilIDpictureButton)

        label2.text = "Company Logo".localiz()
        label2.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label2.font = .font(for: .regular, size: 16)
        label2.textAlignment = .center
        label2.bottom(15).width(135).height(19).centerHorizontally()

        icon2.image = UIImage(named: "Group 2710")
        icon2.top(23).width(28).height(22).centerHorizontally()
        
        civilIDPictureView.backgroundColor = UIColor(named: AdaptiveColors.buttonGrey.rawValue)
        civilIDPictureView.layer.cornerRadius = 10
        civilIDPictureView.trailing(16).width(167).height(91)
        civilIDPictureView.Top == carType.Bottom + 12  + 22
        
        civilIDpictureButton.fillContainer()
        
        //view 3
        
        let label3 = UILabel()
        let icon3 = UIImageView()
        coverageLocationsView.subviews(label3)
        coverageLocationsView.subviews(icon3)
        civilIDPictureView.subviews(civilIDpictureButton)

        label3.text = "Company Location".localiz()
        label3.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label3.font = .font(for: .regular, size: 16)
        label3.textAlignment = .center
        label3.bottom(15).width(135).height(19).centerHorizontally()

        icon3.image = UIImage(named: "Group 2711")
        icon3.contentMode = .scaleAspectFit
        icon3.top(23).width(28).height(22).centerHorizontally()
        
        coverageLocationsView.backgroundColor = UIColor(named: AdaptiveColors.buttonGrey.rawValue)
        coverageLocationsView.layer.cornerRadius = 10
        coverageLocationsView.leading(16).width(167).height(91)
        coverageLocationsView.Top == civilIDPictureView.Bottom + 10
        
        civilIDpictureButton.fillContainer()
        
        // view 4
        
        let label4 = UILabel()
        let icon4 = UIImageView()
        categoryView.subviews(label4)
        categoryView.subviews(icon4)
        categoryView.subviews(categoryButton)

        label4.text = "Category".localiz()
        label4.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label4.font = .font(for: .regular, size: 16)
        label4.textAlignment = .center
        label4.bottom(15).width(135).height(19).centerHorizontally()

        icon4.image = UIImage(named: "Path 2437")
        icon4.top(23).width(28).height(22).centerHorizontally()
        
        categoryView.backgroundColor = UIColor(named: AdaptiveColors.buttonGrey.rawValue)
        categoryView.layer.cornerRadius = 10
        categoryView.trailing(16).width(167).height(91)
        categoryView.Top == civilIDPictureView.Bottom + 10
        
        categoryButton.fillContainer()
        
        // Bottom View
        
        bottomView.subviews(nextButton)
        
        //nextButton.backgroundColor = #colorLiteral(red: 0.5764705882, green: 0.8352941176, blue: 0, alpha: 1)
        nextButton.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.3607843137, blue: 0.1960784314, alpha: 1)
        nextButton.layer.borderWidth = 1
        nextButton.top(10).width(250).height(44).centerHorizontally()
        nextButton.setTitleColor(#colorLiteral(red: 0.06666666667, green: 0.3607843137, blue: 0.1960784314, alpha: 1), for: .normal)
        nextButton.setTitle("Next".localiz(), for: .normal)
        nextButton.titleLabel?.font = .font(for: .regular, size: 16)
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
