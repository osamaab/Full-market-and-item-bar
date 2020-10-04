//
//  ChangeLanguageViewController.swift
//  talabyeh
//
//  Created by loai elayan on 10/4/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import LanguageManager_iOS

class ChangeLanguageViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    @IBAction func dismissButton(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func setLanguage(_ sender: Any)
    {
        let selectedLanguage: Languages = (sender as AnyObject).tag == 1 ? .en : .ar
              
        // change the language.
        LanguageManager.shared.setLanguage(language: selectedLanguage,
                                           viewControllerFactory: { title -> UIViewController in
          // you can check the title to set a specific for specific scene.
          print(title ?? "")
          // get the storyboard.
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          // instantiate the view controller that you want to show after changing the language.
          return storyboard.instantiateInitialViewController()!
        }) { view in
          // do custom animation
          view.transform = CGAffineTransform(scaleX: 2, y: 2)
          view.alpha = 0
        }
    }
    
    
    

}
