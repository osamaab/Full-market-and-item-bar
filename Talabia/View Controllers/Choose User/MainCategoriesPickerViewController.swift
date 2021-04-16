//
//  MainCategoriesPickerViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 20/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia
import SDWebImage
import XCoordinator

protocol MainCategoriesPickerViewControllerDelegate: class {
    func mainCategoriesViewController(_ sender: MainCategoriesPickerViewController, didFinishWith categories: [MainCategory])
    func MainCategoriesPickerViewControllerDidChooseSkip(_ sender: MainCategoriesPickerViewController)
}

class MainCategoriesPickerViewController: ContentViewController<[MainCategory]> {
    
    static func allCategoriesContent() -> APIContentRepositoryType<GeneralAPI, [MainCategory]> {
        .init(.categories)
    }
    
    lazy var headerView: AuthHeaderView = .init(elements: [
        .title("Welcome to TALABIA"),
        .type(self.userType),
        .subtitle("Please choose the category of resellers You can serve")
    ])
    
    lazy var collectionView: UICollectionView = configureCollectionView()
    lazy var bottomView: BottomNextButtonView = .init(title: "Next")
    
    let userType: UserType
    
    var categories: [MainCategory] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var selectedCategories: [MainCategory] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    weak var delegate: MainCategoriesPickerViewControllerDelegate?
    
    
    init<Repository: ContentRepositoryType>(contentRepository: Repository,
                                            userType: UserType,
                                            title: String) where Repository.ContentType == ContentType {
       
        self.userType = userType
        super.init(contentRepository: contentRepository)
        self.title = title
        self.navigationItem.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func setupViewsBeforeTransitioning() {
        self.title = "Category"
        let textAttributes = [NSAttributedString.Key.foregroundColor:DefaultColorsProvider.elementUnselected]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), action: {
            AppDelegate.shared.router.trigger(.chooseUserType)
        })
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip", action: { [unowned self] in
            self.delegate?.MainCategoriesPickerViewControllerDidChooseSkip(self)
        })
        self.navigationItem.rightBarButtonItem?.tintColor = DefaultColorsProvider.tintPrimary
        
        
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.subviews {
            headerView
            collectionView
            bottomView
        }
        
        headerView.Top == view.safeAreaLayoutGuide.Top + 15
        headerView.leading(20).centerHorizontally()
        
        collectionView.leading(0).trailing(0)
        collectionView.Top == headerView.Bottom + 40

        bottomView.leading(0).trailing(0).bottom(0)
        bottomView.Top == collectionView.Bottom
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        
        bottomView.nextButton.add(event: .touchUpInside) { [unowned self] in
            if selectedCategories.count > 0 {
                self.delegate?.mainCategoriesViewController(self, didFinishWith: self.selectedCategories)
            }
           return
        }
    }
    
    override func contentRequestDidSuccess(with content: [MainCategory]) {
        self.categories = content
        self.collectionView.reloadData()
    }
}

extension MainCategoriesPickerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: MainCategoryCollectionViewCell.self, for: indexPath)
        let item = self.categories[indexPath.item]
        
        cell.titleLabel.text = item.title
        cell.imageView.sd_setImage(with: item.logo)
        cell.checkboxView.isSelected = self.selectedCategories.contains(item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = categories[indexPath.item]
        if self.selectedCategories.contains(item){
            self.selectedCategories.remove(at: selectedCategories.firstIndex(of: item)!)
        } else {
            self.selectedCategories.append(item)
        }
        
        self.collectionView.reloadData()
    }
}

extension MainCategoriesPickerViewController {
    func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: MainCategoryCollectionViewCell.self)
        
        return collectionView
    }
    
    func generateLayout() -> UICollectionViewLayout {
         //1
        let itemSize = NSCollectionLayoutSize(
           widthDimension: .fractionalWidth(1.0),
           heightDimension: .fractionalHeight(1.0))
         let ItemSpace = NSCollectionLayoutItem(layoutSize: itemSize)
        ItemSpace.contentInsets = NSDirectionalEdgeInsets(
          top: 17,
          leading: 10,
          bottom: 17,
          trailing: 10)
         //2
         let groupSize = NSCollectionLayoutSize(
           widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.31))
         let group = NSCollectionLayoutGroup.horizontal(
           layoutSize: groupSize,
           subitem: ItemSpace,
           count: 3)
        group.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
         //3
         let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
         let layout = UICollectionViewCompositionalLayout(section: section)
         return layout
       
    }
}



