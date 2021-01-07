//
//  CategoriesPickerViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 20/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia
import SDWebImage

class CategoriesPickerViewController: UIViewController {
    
    lazy var headerView: AuthHeaderView = .init(elements: [
        .title("Welcome to TALABYEH"),
        .type,
        .subtitle("Please choose the category of resellers You can serve")
    ])
    
    lazy var collectionView: UICollectionView = configureCollectionView()
    lazy var bottomView: BottomNextButtonView = .init(title: "Next")
    
    var categories: [CategoryItem] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var selectedCategories: [CategoryItem] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var onNext: (() -> Void)?
    
    init(title: String){
        super.init(nibName: nil, bundle: nil)
        self.title = title
        self.navigationItem.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(close))

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
        collectionView.Top == headerView.Bottom
        
        bottomView.leading(0).trailing(0).bottom(0)
        bottomView.Top == collectionView.Bottom
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        
        bottomView.nextButton.add(event: .touchUpInside) {
            self.onNext?()
        }
    }
}

extension CategoriesPickerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: CategoryItemCollectionViewCell.self, for: indexPath)
        let item = self.categories[indexPath.item]
        
        cell.titleLabel.text = item.title
        cell.imageView.sd_setImage(with: item.imageURL)
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

extension CategoriesPickerViewController {
    func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: CategoryItemCollectionViewCell.self)
        
        return collectionView
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let itemHeightDimension: NSCollectionLayoutDimension = .absolute(120)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                              heightDimension: itemHeightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: itemHeightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        group.interItemSpacing = .fixed(15)
        group.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        section.interGroupSpacing = 15
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}



