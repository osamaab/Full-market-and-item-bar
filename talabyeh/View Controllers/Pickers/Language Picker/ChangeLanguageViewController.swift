//
//  ChangeLanguageViewController.swift
//  talabyeh
//
//  Created by loai elayan on 10/4/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import LanguageManager_iOS


//TODO: Change it to language picker type, not change language
class ChangeLanguageViewController: UIViewController {
    
    @IBOutlet weak var selectLanguageLabel: UILabel!
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var arabicButton: UIButton!
    @IBOutlet weak var englishCheckMarkImage: UIImageView!
    @IBOutlet weak var arabicCheckMarkImage: UIImageView!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var upperView: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        englishButton.titleLabel?.font = .font(for: .bold, size: 17)
        selectLanguageLabel.font = .font(for: .medium, size: 16)
        arabicButton.titleLabel?.font = .font(for: .medium, size: 17)

        
        if LanguageManager.shared.currentLanguage == .ar{
            englishButton.contentHorizontalAlignment = .right
            arabicButton.contentHorizontalAlignment = .right
            
            
            arabicCheckMarkImage.isHidden = false
            englishCheckMarkImage.isHidden = true

            
        } else {
            arabicCheckMarkImage.isHidden = true
            englishCheckMarkImage.isHidden = false
        }
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = upperView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        upperView.addSubview(blurEffectView)
        let button = UIButton(frame: upperView.frame)
        button.addTarget(self, action: #selector(self.dismissButton), for: .touchUpInside)
        upperView.addSubview(button)
    }
    
    @objc func dismissButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func setLanguage(_ sender: Any) {
    }
}
