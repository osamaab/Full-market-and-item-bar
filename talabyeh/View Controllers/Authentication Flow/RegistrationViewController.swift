//
//  ViewController.swift
//  talabyeh
//
//  Created by loai elayan on 10/4/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import LanguageManager_iOS

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var changeLanguageButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.layer.borderColor = #colorLiteral(red: 0.0639943555, green: 0.4317309856, blue: 0.2556748986, alpha: 1)
        signInButton.layer.borderWidth = 1
        //signInButton.layer.cornerRadius = 10
        
        signUpButton.layer.borderColor = #colorLiteral(red: 0.0639943555, green: 0.4317309856, blue: 0.2556748986, alpha: 1)
        signUpButton.layer.borderWidth = 1
        //signUpButton.layer.cornerRadius = 10

        if LanguageManager.shared.currentLanguage == .ar{
            welcomeLabel.font = UIFont(name: "DINNextLTW23-Light", size: 28)
            signUpButton.titleLabel?.font = UIFont(name: "DINNextLTW23-Regular", size: 17)
            signInButton.titleLabel?.font = UIFont(name: "DINNextLTW23-Regular", size: 17)
            changeLanguageButton.titleLabel?.font = UIFont(name: "DINNextLTW23-Regular", size: 17)
            signInButton.contentVerticalAlignment = .top
            signUpButton.contentVerticalAlignment = .top
        }
    }
    
    @IBAction func changeLanguage(_ sender: Any) {
        let changeLanguageVC = (self.storyboard?.instantiateViewController(withIdentifier: "ChangeLanguage"))!
        self.present(changeLanguageVC, animated: true, completion: nil)
    }
    
    
    @IBAction func signInButton(_ sender: Any) {
        let vc = SignInViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

