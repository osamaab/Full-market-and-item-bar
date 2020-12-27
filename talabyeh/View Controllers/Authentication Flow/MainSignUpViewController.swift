//
//  MainSignUpViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/6/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import LanguageManager_iOS
import Stevia
import SDWebImage


class MainSignUpViewController: UIViewController {

    @IBOutlet weak var companyView: RoundedView!
    @IBOutlet weak var distributorView: RoundedView!
    @IBOutlet weak var resellerView: RoundedView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var letsgetStartedLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var distributorLabel: UILabel!
    @IBOutlet weak var resellerLabel: UILabel!
    @IBOutlet weak var nextButton: RoundedButton!
    @IBOutlet weak var signUplabel: UILabel!
    @IBOutlet weak var signUpBackButtonCenterY: NSLayoutConstraint!
    
    @IBOutlet weak var companyImage: UIImageView!
    
    @IBOutlet weak var distributorImage: UIImageView!
    @IBOutlet weak var resellerImage: UIImageView!
    
    @IBOutlet weak var lineView1: UIView!
    @IBOutlet weak var lineView2: UIView!
    @IBOutlet weak var lineView3: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if LanguageManager.shared.currentLanguage == .ar{
            backButton.transform  = CGAffineTransform(scaleX: -1, y: 1)
            
            welcomeLabel.font = UIFont(name: "DINNextLTW23-Bold", size: 22)
            letsgetStartedLabel.font = UIFont(name: "DINNextLTW23-Regular", size: 17)
            companyLabel.font = UIFont(name: "DINNextLTW23-Heavy", size: 17)
            distributorLabel.font = UIFont(name: "DINNextLTW23-Heavy", size: 17)
            resellerLabel.font = UIFont(name: "DINNextLTW23-Heavy", size: 17)
            nextButton.titleLabel?.font = UIFont(name: "DINNextLTW23-Regular", size: 17)
            signUplabel.font = getArabicFont(17, .regular)

            self.view.removeConstraint(signUpBackButtonCenterY)
            backButton.CenterY == signUplabel.CenterY + 3
            
            nextButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0)
        }
        
        
        lineView1.backgroundColor = DefaultColorsProvider.tintPrimary
        lineView2.backgroundColor = DefaultColorsProvider.tintPrimary
        lineView3.backgroundColor = DefaultColorsProvider.tintPrimary
        
        self.companyImage.image = self.companyImage.image?.withRenderingMode(.alwaysTemplate)
        self.companyImage.tintColor = DefaultColorsProvider.tintPrimary
        
        self.distributorImage.image = self.companyImage.image?.withRenderingMode(.alwaysTemplate)
        self.distributorImage.tintColor = DefaultColorsProvider.tintPrimary
        
        self.resellerImage.image = self.companyImage.image?.withRenderingMode(.alwaysTemplate)
        self.resellerImage.tintColor = DefaultColorsProvider.backgroundPrimary
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var chosenUserType: UserTypeEnum?

    @IBAction func chooseMerchantType(_ sender: Any)
    {
        let tag = (sender as AnyObject).tag!
        if tag == 0{
            companyView.backgroundColor = DefaultColorsProvider.tintSecondary
            distributorView.backgroundColor = DefaultColorsProvider.containerBackground4
            resellerView.backgroundColor = DefaultColorsProvider.containerBackground4
            
            chosenUserType = .Company
        }else if tag == 1{
            distributorView.backgroundColor = DefaultColorsProvider.tintSecondary
            companyView.backgroundColor = DefaultColorsProvider.containerBackground4
            resellerView.backgroundColor = DefaultColorsProvider.containerBackground4
            
            chosenUserType = .Distributor
        }else if tag == 2{
            resellerView.backgroundColor = DefaultColorsProvider.tintSecondary
            distributorView.backgroundColor = DefaultColorsProvider.containerBackground4
            companyView.backgroundColor = DefaultColorsProvider.containerBackground4
            
            chosenUserType = .Reseller
        }
        
        nextButton.isEnabled = true
    }
    
    @IBAction func next(_ sender: Any) {
//        switch chosenUserType {
//        case .Distributor:
//            let distributorSignUp = DistributorSignUpViewController()
//            self.navigationController?.pushViewController(distributorSignUp, animated: true)
//        default:
//            let signUpWizardVC = SignUpWizardViewController()
//            signUpWizardVC.chosenUserType = self.chosenUserType!
//            self.navigationController?.pushViewController(signUpWizardVC, animated: true)
//        }

        let signupSample = SampleSignupViewController()
        self.navigationController?.pushViewController(signupSample, animated: true)
    }
}

enum UserTypeEnum {
    case Company
    case Distributor
    case Reseller
}
