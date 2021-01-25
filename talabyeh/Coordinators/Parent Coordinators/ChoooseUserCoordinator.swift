//
//  ChoooseUserCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 19/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import XCoordinator

enum ChooseUserRoute: Route {
    case chooseUserType
    case chooseCategories(UserType)
    case subCategories([MainCategory])
}


protocol ChooseUserCoordinatorDelegate: class {
    func chooseUserCoordinator(_ sender: ChoooseUserCoordinator, didFinishWith output: ChoooseUserCoordinator.Output)
}

class ChoooseUserCoordinator: NavigationCoordinator<ChooseUserRoute> {
    
    struct Output {
        let userType: UserType
        let categories: [MainCategory]
        let subCategories: [SubCategory]
    }
    
    fileprivate var userType: UserType?
    
    weak var coordinatorDelegate: ChooseUserCoordinatorDelegate?
    
    init(delegate: ChooseUserCoordinatorDelegate?){
        self.coordinatorDelegate = delegate
        super.init(rootViewController: NavigationController(), initialRoute: .chooseUserType)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .chooseUserType:
            let chooseUserVC = ChooseUserViewController()
            chooseUserVC.delegate = self
            return .push(chooseUserVC)
        case .chooseCategories(let userType):
            self.userType = userType
            
            let contentRepository = MainCategoriesPickerViewController.allCategoriesContent()
            let categoriesPicker = MainCategoriesPickerViewController(contentRepository: contentRepository, userType: userType, title: "Choose Categories")
            categoriesPicker.delegate = self
            return .push(categoriesPicker)
        case .subCategories(let categories):
            let categoriesPicker = SubCategoriesPickerViewController(categories: categories, contentRepository: SubCategoriesPickerViewController.emptyContentRepository(with: categories))
            categoriesPicker.delegate = self
            return .push(categoriesPicker)
        }
    }
}

extension ChoooseUserCoordinator: ChooseUserViewControllerDelegate {
    func chooseUserViewController(_ sender: ChooseUserViewController, didFinishWith user: UserType) {
        self.trigger(.chooseCategories(user))
    }
}

extension ChoooseUserCoordinator: MainCategoriesPickerViewControllerDelegate {
    func mainCategoriesViewController(_ sender: MainCategoriesPickerViewController, didFinishWith categories: [MainCategory]) {
        self.trigger(.subCategories(categories))
    }
}

extension ChoooseUserCoordinator: SubCategoriesPickerViewControllerDelegate {
    func subCategoriesViewController(_ sender: SubCategoriesPickerViewController, didFinishWith categories: [SubCategory]) {
        self.coordinatorDelegate?.chooseUserCoordinator(self, didFinishWith: .init(userType: userType!, categories: sender.mainCategories, subCategories: categories))
    }
}
