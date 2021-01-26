//
//  NavigationController.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    let autoShowsCloseButton: Bool
    
    init(rootViewController: UIViewController, autoShowsCloseButton: Bool = false){
        self.autoShowsCloseButton = autoShowsCloseButton
        super.init(rootViewController: rootViewController)
    }
    
    init(autoShowsCloseButton: Bool = false){
        self.autoShowsCloseButton = autoShowsCloseButton
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.autoShowsCloseButton = true
        super.init(coder: aDecoder)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationBar.tintColor = DefaultColorsProvider.elementBarTint
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = DefaultColorsProvider.elementBarBackground
        
        navigationBar.titleTextAttributes = [
            .foregroundColor: DefaultColorsProvider.elementBarTint,
            .font: UIFont.font(for: .bold, size: 16)
        ]
        
        navigationBar.largeTitleTextAttributes = [
            .foregroundColor: DefaultColorsProvider.elementBarTint,
            .font: UIFont.font(for: .bold, size: 24)
        ]
        
        navigationBar.backIndicatorImage = UIImage(named: "back")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isBeingPresented && autoShowsCloseButton {
            viewControllers.first?.navigationItem.backBarButtonItem = .init(title: "", style: .plain, target: nil, action: nil)
            viewControllers.first?.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(close))
        }
    }
}

extension UIViewController {
    @discardableResult
    func embededInNavigationController(autoShowsCloseButton: Bool = true, showsNavigationBar: Bool = true) -> NavigationController {
        let navigationController = NavigationController(rootViewController: self, autoShowsCloseButton: autoShowsCloseButton)
        
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

