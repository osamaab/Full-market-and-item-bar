//
//  ViewController.swift
//  talabyeh
//
//  Created by loai elayan on 10/4/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.layer.borderColor = #colorLiteral(red: 0.0639943555, green: 0.4317309856, blue: 0.2556748986, alpha: 1)
        signInButton.layer.borderWidth = 1
        signInButton.layer.cornerRadius = 10
        
        signUpButton.layer.borderColor = #colorLiteral(red: 0.0639943555, green: 0.4317309856, blue: 0.2556748986, alpha: 1)
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.cornerRadius = 10

    }


}

