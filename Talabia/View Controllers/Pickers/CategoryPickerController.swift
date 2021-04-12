//
//  CategoryPickerController.swift
//  talabyeh
//
//  Created by Hussein Work on 20/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

protocol CategoryPickerControllerDelegate: class {
    func categoryPickerController(_ sender: CategoryPickerController, didFinishWith categories: [SubCategory])
}

class CategoryPickerController: NSObject {
    
    let title = "Select Category"
    
    let navigationController: NavigationController
    let categoriesViewController: SubCategoriesPickerViewController
    
    weak var delegate: CategoryPickerControllerDelegate?
    
    init(selectedCategories: [SubCategory] = [],
         delegate: CategoryPickerControllerDelegate){
        
        let anyContentRepo: AnyContentRepository<[MainCategory]>
        if let fromPreferences = DefaultPreferencesController.shared.selectedCategories {
            anyContentRepo = ConstantContentRepository(content: fromPreferences).eraseToAnyContentRepository()
        } else {
            anyContentRepo = APIContentRepositoryType<GeneralAPI, [MainCategory]>(.categories).eraseToAnyContentRepository()
        }
        
        
        self.categoriesViewController = .init(contentRepository: anyContentRepo)
        self.categoriesViewController.selectionType = .single
        self.categoriesViewController.navigationItem.title = title
        
        self.navigationController = NavigationController(rootViewController: self.categoriesViewController, style: .secondary, autoShowsCloseButton: true)
        self.delegate = delegate
        
        super.init()
        
        self.categoriesViewController.delegate = self
    }
    
    func present(on viewController: UIViewController){
        viewController.present(navigationController, animated: true, completion: nil)
    }
}

extension CategoryPickerController: SubCategoriesPickerViewControllerDelegate {
    func subCategoriesViewController(_ sender: SubCategoriesPickerViewController, didFinishWith categories: [SubCategory]) {
        sender.dismiss(animated: true) {
            self.delegate?.categoryPickerController(self, didFinishWith: categories)
        }
    }
}
