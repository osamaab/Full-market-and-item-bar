//
//  CategoryPickerController.swift
//  talabyeh
//
//  Created by Hussein Work on 20/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

protocol CategoryPickerControllerDelegate: class {
    func categoryPickerController(_ sender: CategoryPickerController, didFinishWith categories: [MainCategory])
}

class CategoryPickerController: NSObject {
    
    let title = "Category"
    
    let navigationController: UINavigationController
    let categoriesViewController: MainCategoriesPickerViewController
    
    weak var delegate: CategoryPickerControllerDelegate?
    
    init(selectedCategories: [MainCategory] = [], delegate: CategoryPickerControllerDelegate){
        self.categoriesViewController = .init(contentRepository: MainCategoriesPickerViewController.allCategoriesContent(), userType: .company, title: "")
        self.navigationController = NavigationController(rootViewController: categoriesViewController, style: .secondary)
        self.delegate = delegate
        
        super.init()
        
        navigationController.navigationBar.barTintColor = DefaultColorsProvider.backgroundPrimary
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.tintColor = DefaultColorsProvider.textPrimary1
        navigationController.navigationBar.titleTextAttributes = [
            .foregroundColor: DefaultColorsProvider.textSecondary1,
            .font: UIFont.font(for: .semiBold, size: 17)
        ]
        
        categoriesViewController.selectedCategories = selectedCategories
//        categoriesViewController.onNext = { [unowned self] in
//            self.delegate?.categoryPickerController(self, didFinishWith: Array(self.categoriesViewController.selectedCategories))
//            self.categoriesViewController.dismiss(animated: true, completion: nil)
//        }
    }
    
    func present(on viewController: UIViewController){
        viewController.present(navigationController, animated: true, completion: nil)
    }
}
