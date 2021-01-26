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
        
        if LanguageManager.shared.currentLanguage == .ar{
            englishButton.contentHorizontalAlignment = .right
            arabicButton.contentHorizontalAlignment = .right
            
            selectLanguageLabel.font = getArabicFont(16, .regular)
            englishButton.titleLabel?.font = getArabicFont(17, .regular)
            arabicButton.titleLabel?.font = getArabicFont(17, .bold)
            
            
            
            arabicCheckMarkImage.isHidden = false
            englishCheckMarkImage.isHidden = true

            
        } else {
            arabicCheckMarkImage.isHidden = true
            englishCheckMarkImage.isHidden = false
            
            englishButton.titleLabel?.font = getEnglishFont(17, .bold)
            selectLanguageLabel.font = getEnglishFont(16, .medium)
            arabicButton.titleLabel?.font = getEnglishFont(17, .medium)
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
