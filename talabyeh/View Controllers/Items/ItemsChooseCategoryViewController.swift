//
//  ItemsChooseCategoryViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 21/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

/**
 This ViewController inhirits from the ItemCategoriesViewController, cause we don't want to repeat ourselves, things look almost the same except for some overrides
 */
class ItemsChooseCategoryViewController: ItemCategoriesViewController {
    
    enum ViewMode: Int {
        case oldCategory
        case newCategory
        
        var index: Int {
            self == .oldCategory ? 1 : 0
        }
    }
    
    let segmentedControl: BigSegmentedControl = .init(items: ["New Category", "Old Category"])
    let bottomNextView: BottomNextButtonView = .init(title: "Next")
    let newCategoryTextField: BorderedTextField = .init()
    
    fileprivate var currentViewMode: ViewMode = .oldCategory

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.contentInset.bottom += 100
        
        self.setViewMode(.oldCategory, animated: false)
        
        self.newCategoryTextField.placeholder = "Category Name"
        
        self.segmentedControl.select(index: self.currentViewMode.index, animated: false)
        self.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
    }
    
    override func setupCollectionView() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomNextView.translatesAutoresizingMaskIntoConstraints = false
        newCategoryTextField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(segmentedControl)
        view.addSubview(collectionView)
        view.addSubview(bottomNextView)
        view.addSubview(newCategoryTextField)
        
        segmentedControl.Top == view.safeAreaLayoutGuide.Top + 20
        segmentedControl.leading(20).trailing(20)
        segmentedControl.select(index: 0, animated: true)
        
        collectionView.Top == segmentedControl.Bottom
        collectionView.leading(20).trailing(20)
        collectionView.Bottom == view.safeAreaLayoutGuide.Bottom
        
        bottomNextView.bottom(0).leading(0).trailing(0)
        
        newCategoryTextField.Leading == segmentedControl.Leading
        newCategoryTextField.Trailing == segmentedControl.Trailing
        newCategoryTextField.Top == segmentedControl.Bottom + 20
        newCategoryTextField.Height == 50
    }
    
    func setViewMode(_ viewMode: ViewMode, animated: Bool){
        self.currentViewMode = viewMode
        let block = {
            switch viewMode {
            case .oldCategory:
                self.newCategoryTextField.alpha = 0
                self.collectionView.alpha = 1
                break
            case .newCategory:
                self.newCategoryTextField.alpha = 1
                self.collectionView.alpha = 0
                break
            }
        }
        
        if animated {
            UIView.animate(withDuration: 0.3, animations: block)
        } else {
            block()
        }
    }
    
    @objc func segmentedControlValueChanged(){
        let newViewMode: ViewMode = segmentedControl.selectedIndex == 1 ? .oldCategory : .newCategory
        if newViewMode != currentViewMode {
            self.setViewMode(newViewMode, animated: true)
        }
    }
}
