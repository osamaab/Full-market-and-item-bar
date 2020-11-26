//
//  CategoryPickerController.swift
//  talabyeh
//
//  Created by Hussein Work on 20/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

struct CategoryItem: Hashable, Equatable {
    let title: String
    let imageURL: URL?
    
    // sample id, so we make sure each category is different from the other one
    let id = UUID().uuidString
}

protocol CategoryPickerControllerDelegate: class {
    func categoryPickerController(_ sender: CategoryPickerController, didFinishWith categories: [CategoryItem])
}

class CategoryPickerController: NSObject {
    
    let title = "Category"
    
    let navigationController: UINavigationController
    let categoriesViewController: CategoriesPickerViewController
    
    weak var delegate: CategoryPickerControllerDelegate?
    
    init(selectedCategories: [CategoryItem] = [], delegate: CategoryPickerControllerDelegate){
        self.categoriesViewController = .init(title: title)
        self.navigationController = UINavigationController(rootViewController: self.categoriesViewController)
        self.delegate = delegate
        
        super.init()
        
        navigationController.navigationBar.barTintColor = .white
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.tintColor = DefaultColorsProvider.text
        navigationController.navigationBar.titleTextAttributes = [
            .foregroundColor: DefaultColorsProvider.secondaryText,
            .font: UIFont.font(for: .semiBold, size: 17)
        ]
        
        categoriesViewController.selectedCategories = selectedCategories
        categoriesViewController.onNext = { [unowned self] in
            self.delegate?.categoryPickerController(self, didFinishWith: Array(self.categoriesViewController.selectedCategories))
            self.categoriesViewController.dismiss(animated: true, completion: nil)
        }
        
        categoriesViewController.categories = (0..<11).map {
            CategoryItem(title: "Category \($0)", imageURL: URL(string: "http://placekitten.com/200/300"))
        }
    }
    
    func present(on viewController: UIViewController){
        viewController.present(navigationController, animated: true, completion: nil)
    }
}
