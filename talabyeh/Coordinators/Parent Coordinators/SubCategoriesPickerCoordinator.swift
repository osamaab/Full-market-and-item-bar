//
//  SubCategoriesPickerCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 02/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import XCoordinator

enum SubCategoriesPickerRoute: Route {
    case new(UserType)
    case from([MainCategory])
    case dismiss
}


protocol SubCategoriesPickerCoordinatorDelegate: class {
    func subCategoriesPickerCoordinator(_ sender: SubCategoriesPickerCoordinator, didFinishWith categories: [SubCategory])
}

class SubCategoriesPickerCoordinator: NavigationCoordinator<SubCategoriesPickerRoute> {
    
    
    weak var coordinatorDelegate: SubCategoriesPickerCoordinatorDelegate?
    
    init(initialRoute: RouteType, delegate: SubCategoriesPickerCoordinatorDelegate?){
        self.coordinatorDelegate = delegate
        super.init(rootViewController: NavigationController(style: .secondary,
                                                            autoShowsCloseButton: true),
                   initialRoute: initialRoute)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .new(let userType):
            let mainCategoriesPicker = MainCategoriesPickerViewController(contentRepository: MainCategoriesPickerViewController.allCategoriesContent(), userType: userType, title: "Choose Main Categories")
            mainCategoriesPicker.delegate = self
            return .push(mainCategoriesPicker)
        case .from(let mainCategories):
            let subCatVC = SubCategoriesPickerViewController(categories: mainCategories,
                                                             contentRepository: SubCategoriesPickerViewController.fromCategories(with: mainCategories))
            subCatVC.delegate = self
            return .push(subCatVC)
        case .dismiss:
            return .dismiss()
        }
    }
}

extension SubCategoriesPickerCoordinator: MainCategoriesPickerViewControllerDelegate {
    func mainCategoriesViewController(_ sender: MainCategoriesPickerViewController, didFinishWith categories: [MainCategory]) {
        
        // now move on to sub-categories
        self.trigger(.from(categories))
    }
}

extension SubCategoriesPickerCoordinator: SubCategoriesPickerViewControllerDelegate {
    func subCategoriesViewController(_ sender: SubCategoriesPickerViewController, didFinishWith categories: [SubCategory]) {
        self.coordinatorDelegate?.subCategoriesPickerCoordinator(self, didFinishWith: categories)
        self.trigger(.dismiss)
    }
}


