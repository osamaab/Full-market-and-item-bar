//
//  MainSignUpViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/6/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import LanguageManager_iOS

class MainSignUpViewController: UIViewController {

    @IBOutlet weak var companyView: RoundedEdgesView!
    @IBOutlet weak var distributorView: RoundedEdgesView!
    @IBOutlet weak var resellerView: RoundedEdgesView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var letsgetStartedLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var distributorLabel: UILabel!
    @IBOutlet weak var resellerLabel: UILabel!
    @IBOutlet weak var nextButton: RoundedEdgesButton!
    
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
 
            
            
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func chooseMerchantType(_ sender: Any)
    {
        let tag = (sender as AnyObject).tag!
        if tag == 0{
            companyView.backgroundColor = #colorLiteral(red: 0.7823992372, green: 0.9342591763, blue: 0.2648603916, alpha: 1)
            distributorView.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            resellerView.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        }else if tag == 1{
            distributorView.backgroundColor = #colorLiteral(red: 0.7823992372, green: 0.9342591763, blue: 0.2648603916, alpha: 1)
            companyView.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            resellerView.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        }else if tag == 2{
            resellerView.backgroundColor = #colorLiteral(red: 0.7823992372, green: 0.9342591763, blue: 0.2648603916, alpha: 1)
            distributorView.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            companyView.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
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
