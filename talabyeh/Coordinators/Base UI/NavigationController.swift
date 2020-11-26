//
//  NavigationController.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    fileprivate var showsCloseButton: Bool = false

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationBar.tintColor = .white
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = DefaultColorsProvider.darkerTint
        
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.font(for: .bold, size: 16)
        ]
        
        navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.font(for: .bold, size: 24)
        ]
        
        navigationBar.backIndicatorImage = UIImage(named: "back")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isBeingPresented {
            viewControllers.first?.navigationItem.backBarButtonItem = .init(title: "", style: .plain, target: nil, action: nil)
            viewControllers.first?.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(close))
        }
    }
}

extension UIViewController {
    @discardableResult
    func embededInNavigationController(showsCloseButton: Bool = true, showsNavigationBar: Bool = true) -> NavigationController {
        let navigationController = NavigationController(rootViewController: self)
        navigationController.showsCloseButton = showsCloseButton
        
        if !showsNavigationBar {
            navigationController.setNavigationBarHidden(true, animated: false)
        }

        
        return navigationController
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func close(){
        dismiss(animated: true, completion: nil)
    }
}

