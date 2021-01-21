//
//  SubCategoriesPickerViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 19/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Stevia
import SDWebImage

protocol SubCategoriesPickerViewControllerDelegate: class {
    func subCategoriesViewController(_ sender: SubCategoriesPickerViewController, didFinishWith categories: [SubCategory])
}

class SubCategoriesPickerViewController: ContentViewController<[SubCategory]> {
    
    static func emptyContentRepository(with categories: [MainCategory]) -> ConstantContentRepository<[SubCategory]> {
        .init(content: [])
    }
    
    struct MainCategoryWithSubCategories {
        var mainCategory: MainCategory
        var categories: [SubCategory]
    }
    
    static let headerElementKind = "header"
    
    lazy var titleLabel: UILabel = .init()
    lazy var collectionView: UICollectionView = configureCollectionView()
    lazy var bottomView: BottomNextButtonView = .init(title: "Next")
    
    
    var mainCategories: [MainCategory]
    var items: [MainCategoryWithSubCategories]
    var categories: [SubCategory]
    var selectedCategories: [SubCategory]
    
    var delegate: SubCategoriesPickerViewControllerDelegate?
    
    init<Repository: ContentRepositoryType>(categories: [MainCategory], contentRepository: Repository) where Repository.ContentType == ContentType {
        
        self.mainCategories = categories
        self.items = mainCategories.map { MainCategoryWithSubCategories(mainCategory: $0, categories: []) }
        self.categories = []
        self.selectedCategories = []
        
        super.init(contentRepository: contentRepository)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViewsBeforeTransitioning() {
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            titleLabel
            collectionView
            bottomView
        }
        
        titleLabel.text = "Select your sub categories"
        titleLabel.font = .font(for: .regular, size: 17)
        titleLabel.textColor = DefaultColorsProvider.tintPrimary
        
        titleLabel.Top == view.safeAreaLayoutGuide.Top + 15
        titleLabel.leading(20).centerHorizontally()
        
        collectionView.leading(0).trailing(0)
        collectionView.Top == titleLabel.Bottom + 15
        
        bottomView.leading(0).trailing(0).bottom(0)
        bottomView.Top == collectionView.Bottom
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        
        bottomView.nextButton.add(event: .touchUpInside) { [unowned self] in
            self.delegate?.subCategoriesViewController(self, didFinishWith: self.selectedCategories)
        }
    }
    
    override func contentRequestDidSuccess(with content: [SubCategory]) {
        self.categories = content
        for category in self.categories {
            guard let indexOfParent = (self.items.firstIndex { $0.mainCategory.id == category.categoryID }) else {
                continue
            }
            
            items[indexOfParent].categories.append(category)
        }
        
        self.collectionView.reloadData()
    }
}

extension SubCategoriesPickerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items[section].categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueCell(cellClass: SubCategoryCollectionViewCell.self, for: indexPath)
        let category = items[indexPath.section].categories[indexPath.item]
        
        cell.imageView.sd_setImage(with: category.imageURL)
        cell.titleLabel.text = category.title
        cell.checkbox.isHidden = false
        cell.checkbox.isSelected = selectedCategories.contains(category)
        
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == Self.headerElementKind else {
            return .init()
        }
        
        
        let header = collectionView.dequeReusableView(reusableViewType: CategoryCollectionReusableView.self, kind: Self.headerElementKind, for: indexPath)
        let category = self.items[indexPath.section].mainCategory
        
        header.titleLabel.text = category.title
        header.imageView.sd_setImage(with: category.logo)


        return header
    }
}

extension SubCategoriesPickerViewController {
    func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(cellClass: SubCategoryCollectionViewCell.self)
        collectionView.register(reusableViewClass: CategoryCollectionReusableView.self, for: Self.headerElementKind)

        return collectionView
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let itemHeightDimension: NSCollectionLayoutDimension = .estimated(120)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                              heightDimension: itemHeightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: itemHeightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        group.interItemSpacing = .fixed(15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        let boundaryItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .estimated(60))
        let boundaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: boundaryItemSize,
                                                                       elementKind: Self.headerElementKind,
                                                                       alignment: .top)
        section.boundarySupplementaryItems = [
            boundaryItem
        ]
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}



