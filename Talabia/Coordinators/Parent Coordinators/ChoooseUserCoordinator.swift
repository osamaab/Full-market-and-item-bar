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
    case subCategories([MainCategory],UserType)
}


protocol ChooseUserCoordinatorDelegate: class {
    func chooseUserCoordinator(_ sender: ChoooseUserCoordinator, didFinishWith output: ChoooseUserCoordinator.Output)
    func chooseUserCoordinatorDidChooseLogin(_ sender: ChoooseUserCoordinator)
    func chooseUserCoordinator(_ sender: ChoooseUserCoordinator, didChooseSkipWith userType: UserType)
}

class ChoooseUserCoordinator: NavigationCoordinator<ChooseUserRoute> {
    fileprivate var currentFlowCoordinator: Presentable?
    struct Output {
        let userType: UserType
        let categories: [MainCategory]
        let subCategories: [SubCategory]
    }
    
    fileprivate var userType: UserType?
    
    weak var coordinatorDelegate: ChooseUserCoordinatorDelegate?
    
    init(delegate: ChooseUserCoordinatorDelegate?){
        self.coordinatorDelegate = delegate
        super.init(rootViewController: NavigationController(style: .secondary, autoShowsCloseButton: false), initialRoute: .chooseUserType)
       
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
            let categoriesPicker = MainCategoriesPickerViewController( contentRepository: contentRepository, userType: userType, title: "Choose Categories")
            categoriesPicker.delegate = self
            return .push(categoriesPicker)
        case .subCategories(let categories, _):
            let categoriesPicker = SubCategoriesPickerViewController(contentRepository: ConstantContentRepository(content: categories))

            categoriesPicker.delegate = self
            return .push(categoriesPicker)
        
        }
    }
}

extension ChoooseUserCoordinator: ChooseUserViewControllerDelegate {
    func chooseUserViewController(_ sender: ChooseUserViewController, didFinishWith user: UserType) {
        if user == .distributor {
            AppDelegate.shared.router.trigger(.authentication(.signin))
        } else {
            self.trigger(.chooseCategories(user))
        }
        
    }
    
    func chooseUserViewControllerDidChooseLogin(_ sender: ChooseUserViewController) {
        self.coordinatorDelegate?.chooseUserCoordinatorDidChooseLogin(self)
    }
}

extension ChoooseUserCoordinator: MainCategoriesPickerViewControllerDelegate {
    func mainCategoriesViewController(_ sender: MainCategoriesPickerViewController, didFinishWith categories: [MainCategory]) {
        self.trigger(.subCategories(categories, userType!))
    }
    func MainCategoriesPickerViewControllerDidChooseSkip(_ sender: MainCategoriesPickerViewController){
    
        self.coordinatorDelegate?.chooseUserCoordinator(self, didChooseSkipWith: sender.userType)
    }
}

extension ChoooseUserCoordinator: SubCategoriesPickerViewControllerDelegate {
    func subCategoriesViewController(_ sender: SubCategoriesPickerViewController, didFinishWith categories: [SubCategory]) {
        self.coordinatorDelegate?.chooseUserCoordinator(self, didFinishWith: .init(userType: userType!, categories: sender.items, subCategories: categories))
        
        
    }
}
