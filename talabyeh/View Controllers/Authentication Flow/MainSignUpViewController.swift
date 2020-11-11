//
//  MainSignUpViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/6/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
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
            
            //nextButton.contentVerticalAlignment = .top
            nextButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0)
            

            
        }
        
        
        lineView1.backgroundColor = UIColor(named: AdaptiveColors.green.rawValue)
        lineView2.backgroundColor = UIColor(named: AdaptiveColors.green.rawValue)
        lineView3.backgroundColor = UIColor(named: AdaptiveColors.green.rawValue)
        
        self.companyImage.image = self.companyImage.image?.withRenderingMode(.alwaysTemplate)
        self.companyImage.tintColor = UIColor(named: AdaptiveColors.green.rawValue)
        
        self.distributorImage.image = self.companyImage.image?.withRenderingMode(.alwaysTemplate)
        self.distributorImage.tintColor = UIColor(named: AdaptiveColors.green.rawValue)
        
        self.resellerImage.image = self.companyImage.image?.withRenderingMode(.alwaysTemplate)
        self.resellerImage.tintColor = .white
        
        
        
        self.startAnimating()
        
        GeneralRoutes.userTypes.request { (result: Result<Types, Error>) in
            guard case .success(let types) = result else {
                // get the error
                
                return
            }
            
            self.companyLabel.text = types.results[0].name//LanguageManager.shared.currentLanguage == .en ? types![0].en_name : types![0].ar_name
            self.distributorLabel.text = types.results[1].name//LanguageManager.shared.currentLanguage == .en ? types![1].en_name : types![1].ar_name
            self.resellerLabel.text = types.results[2].name//LanguageManager.shared.currentLanguage == .en ? types![2].en_name : types![2].ar_name
            

            
            if let cLogourl = URL(string: types.results[0].logo!), let dLogourl = URL(string:types.results[1].logo!) , let rLogourl = URL(string:types.results[2].logo!)
            {
                print(cLogourl)
//                self.companyImage.sd_setImage(with: cLogourl) { (image, error, cacheType, url) in
//
//                }
                
                self.companyImage.sd_setImage(with: cLogourl) { (image, error, cacheType, url) in
//                    image?.withRenderingMode(.alwaysTemplate)
//                    image?.withTintColor(UIColor(named: AdaptiveColors.green.rawValue)!)
                    
                    self.companyImage.image = image?.withRenderingMode(.alwaysTemplate)
                    self.companyImage.tintColor = UIColor(named: AdaptiveColors.green.rawValue)
                    
                }
                
                self.distributorImage.sd_setImage(with: dLogourl) { (image, error, cacheType, url) in
                    
                    self.distributorImage.image = image?.withRenderingMode(.alwaysTemplate)
                    self.distributorImage.tintColor = UIColor(named: AdaptiveColors.green.rawValue)
                }
                self.resellerImage.sd_setImage(with: rLogourl) { (image, error, cacheType, url) in
                    self.resellerImage.image = image?.withRenderingMode(.alwaysTemplate)
                    self.resellerImage.tintColor = UIColor(named: AdaptiveColors.green.rawValue)
                }
 
                
            }
            self.stopAnimating()
            
            
        }
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    var chosenUserType: UserTypeEnum?
    

    
    @IBAction func chooseMerchantType(_ sender: Any)
    {
        let tag = (sender as AnyObject).tag!
        if tag == 0{
            companyView.backgroundColor = #colorLiteral(red: 0.7823992372, green: 0.9342591763, blue: 0.2648603916, alpha: 1)
            distributorView.backgroundColor = UIColor(named: AdaptiveColors.buttonGrey.rawValue)
            resellerView.backgroundColor = UIColor(named: AdaptiveColors.buttonGrey.rawValue)
            
            chosenUserType = .Company
        }else if tag == 1{
            distributorView.backgroundColor = #colorLiteral(red: 0.7823992372, green: 0.9342591763, blue: 0.2648603916, alpha: 1)
            companyView.backgroundColor = UIColor(named: AdaptiveColors.buttonGrey.rawValue)
            resellerView.backgroundColor = UIColor(named: AdaptiveColors.buttonGrey.rawValue)
            
            chosenUserType = .Distributor
        }else if tag == 2{
            resellerView.backgroundColor = #colorLiteral(red: 0.7823992372, green: 0.9342591763, blue: 0.2648603916, alpha: 1)
            distributorView.backgroundColor = UIColor(named: AdaptiveColors.buttonGrey.rawValue)
            companyView.backgroundColor = UIColor(named: AdaptiveColors.buttonGrey.rawValue)
            
            chosenUserType = .Reseller
        }
        
        nextButton.isEnabled = true
    }
    
    @IBAction func next(_ sender: Any) {
        switch chosenUserType {
        case .Distributor:
            let distributorSignUp = DistributorSignUpViewController()
            self.navigationController?.pushViewController(distributorSignUp, animated: true)
        default:
            let signUpWizardVC = SignUpWizardViewController()
            signUpWizardVC.chosenUserType = self.chosenUserType!
            self.navigationController?.pushViewController(signUpWizardVC, animated: true)
        }

    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

enum UserTypeEnum {
    case Company
    case Distributor
    case Reseller
}
