//
//  NavigationController.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    enum Style {
        /**
         Primary style means the primaryTint is the barTintColor, and elements have elemnentsColor
         */
        case primary
        
        /**
         Secondary refers to that navigation bar barTintColor is backgroundPrimary
         */
        case secondary
    }
    
    let autoShowsCloseButton: Bool
    
    
    var style: Style {
        didSet {
            self.update(for: style)
        }
    }
    
    
    
    init(rootViewController: UIViewController, style: Style = .primary, autoShowsCloseButton: Bool = false){
        self.autoShowsCloseButton = autoShowsCloseButton
        self.style = style
        super.init(rootViewController: rootViewController)
    }
    
    init(style: Style = .primary, autoShowsCloseButton: Bool = false){
        self.autoShowsCloseButton = autoShowsCloseButton
        self.style = style
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.style = .primary
        self.autoShowsCloseButton = true
        super.init(coder: aDecoder)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch navigationBar.barTintColor?.hexString ?? "" {
        case LightSchemeColorProvider.backgroundPrimary.hexString ?? "":
            return .darkContent
        default:
            return .lightContent
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.update(for: self.style)
    }
    
    func update(for style: Style){
        let elementsColor: UIColor = {
            switch self.style {
            case .primary:
                return DefaultColorsProvider.elementBarTint
            case .secondary:
                return DefaultColorsProvider.tintPrimary
            }
        }()
        
        let barTintColor: UIColor = {
            switch self.style {
            case .primary:
                return DefaultColorsProvider.elementBarBackground
            case .secondary:
                return DefaultColorsProvider.backgroundPrimary
            }
        }()
        
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        navigationBar.tintColor = elementsColor
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = barTintColor
        
        navigationBar.titleTextAttributes = [
            .foregroundColor: elementsColor,
            .font: UIFont.font(for: .bold, size: 16)
        ]
        
        navigationBar.largeTitleTextAttributes = [
            .foregroundColor: elementsColor,
            .font: UIFont.font(for: .bold, size: 24)
        ]
        
        navigationBar.backIndicatorImage = UIImage(named: "back")
        self.setNeedsStatusBarAppearanceUpdate()
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
    func embededInNavigationController(style: NavigationController.Style = .primary,
                                       autoShowsCloseButton: Bool = true,
                                       showsNavigationBar: Bool = true) -> NavigationController {
        
        let navigationController = NavigationController(rootViewController: self,
                                                        style: style,
                                                        autoShowsCloseButton: autoShowsCloseButton)
        
        if !showsNavigationBar {
            navigationController.setNavigationBarHidden(true, animated: false)
        }
        
        return navigationController
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func close(){
        self.dismiss(animated: true, completion: nil)
    }
}

