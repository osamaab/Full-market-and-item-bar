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

class SubCategoriesPickerViewController: ContentViewController<[MainCategory]>, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    enum SelectionType: Int {
        case single
        case multiple
    }
    
    static func preferencesCategories() -> ConstantContentRepository<[SubCategory]> {
        guard let subcategories = DefaultPreferencesController.shared.selectedSubCategories else {
            fatalError("")
        }
        
        return .init(content: subcategories)
    }
    
    static let headerElementKind = "header"
    
    lazy var titleLabel: UILabel = .init()
    lazy var collectionView: UICollectionView = configureCollectionView()
    lazy var bottomView: BottomNextButtonView = .init(title: "Next")
    var selectedCategories: [SubCategory] = []
    
    var selectionType: SelectionType = .multiple {
        didSet {
            bottomView.isHidden = self.selectionType == .single
            collectionView.reloadData()
        }
    }
   
    var items: [MainCategory] {
        content ?? []
    }
    
    var delegate: SubCategoriesPickerViewControllerDelegate?
    
    override func setupViewsBeforeTransitioning() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"search-Icon"), action: {})
        addBackButton()
        
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            titleLabel
            collectionView
            bottomView
        }
        
        titleLabel.text = "Select your Sub-Categories"
        titleLabel.font = .font(for: .regular, size: 15)
        titleLabel.textColor = DefaultColorsProvider.tintPrimary
        
        titleLabel.Top == view.safeAreaLayoutGuide.Top + 15
        titleLabel.leading(20).centerHorizontally()
        
        collectionView.leading(0).trailing(0)
        collectionView.Top == titleLabel.Bottom + 15
//        collectionView.Bottom == view.safeAreaLayoutGuide.Bottom
        collectionView.Bottom == view.Bottom
        bottomView.leading(0).trailing(0).bottom(0)
        
        collectionView.contentInset.bottom += 100
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        
        bottomView.nextButton.add(event: .touchUpInside) { [unowned self] in
            if selectedCategories.count > 0 {
                self.delegate?.subCategoriesViewController(self, didFinishWith: self.selectedCategories)
            }
           
        }
    }
    
    override func contentRequestDidSuccess(with content: [MainCategory]) {
        self.collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items[section].subcategories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueCell(cellClass: SubCategoryCollectionViewCell.self, for: indexPath)
        let category = items[indexPath.section].subcategories?[indexPath.item]
        cell.imageView.sd_setImage(with: category?.imageURL)
        cell.titleLabel.text = category?.title
        cell.checkbox.isHidden = selectionType == .single
        cell.checkbox.isSelected = selectedCategories.contains(category!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        guard let item = items[indexPath.section].subcategories?[indexPath.item] else {return}
        if selectionType == .single {
            
            self.selectedCategories.removeAll()
            self.selectedCategories.append(item)
            self.delegate?.subCategoriesViewController(self, didFinishWith: selectedCategories)
            return
        }
        
        if self.selectedCategories.contains(item){
            self.selectedCategories.remove(at: selectedCategories.firstIndex(of: item)!)
        } else {
            self.selectedCategories.append(item)
        }
       
        self.collectionView.reloadItems(at: [indexPath])
       
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == Self.headerElementKind else {
            return .init()
        }
        
        
        let header = collectionView.dequeReusableView(reusableViewType: CategoryCollectionReusableView.self, kind: Self.headerElementKind, for: indexPath)
        let category = self.items[indexPath.section]
        
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
//
        let itemSize = NSCollectionLayoutSize(
           widthDimension: .fractionalWidth(1.0),
           heightDimension: .fractionalHeight(1.0))
         let ItemSpace = NSCollectionLayoutItem(layoutSize: itemSize)
        ItemSpace.contentInsets = NSDirectionalEdgeInsets(
          top: 15,
          leading: 10,
          bottom: 5,
          trailing: 10)
         //2
        let groupSize = NSCollectionLayoutSize(
           widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.39))
         let group = NSCollectionLayoutGroup.horizontal(
           layoutSize: groupSize,
           subitem: ItemSpace,
           count: 3)
//        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
         //3
         let section = NSCollectionLayoutSection(group: group)
//         let layout = UICollectionViewCompositionalLayout(section: section)
//         return layout
        let boundaryItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .estimated(60))
        let boundaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: boundaryItemSize,
                                                                       elementKind: Self.headerElementKind,
                                                                       alignment: .top)
        section.boundarySupplementaryItems = [
            boundaryItem
        ]
        section.orthogonalScrollingBehavior = .none
        return UICollectionViewCompositionalLayout(section: section)
    }
    func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.setTitle("Category", for: .normal)
        backButton.titleEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: -15)
        backButton.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        backButton.titleLabel?.font = .font(for: .bold, size: 17)
        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    @IBAction func backAction(_ sender: UIButton) {
        let _ = navigationController?.popViewController(animated: true)
    }
}



