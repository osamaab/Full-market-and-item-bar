//
//  AllCompaniesViewController.swift
//  Talabia
//
//  Created by Osama Abu hdba on 15/04/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia
class AllCompaniesViewController: ContentViewController<[Company]> {

    lazy var collectionView: UICollectionView = configureCollectionView()
    
    static func allCompanyContent() -> APIContentRepositoryType<MarketAPI, [Company]> {
        .init(.allCompany)
    }
    var items: [Company] {
        content ?? []
    }
    var selectedCategories: [Company] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init<Repository: ContentRepositoryType>(contentRepository: Repository
                                           ) where Repository.ContentType == ContentType {
       
        super.init(contentRepository: contentRepository)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViewsBeforeTransitioning() {
        title = "Items"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"search-Icon"), action: {})
        addBackButton()
               
        view.addSubview(collectionView)

        collectionView.Width == view.Width
        collectionView.Height == view.Height
        collectionView.leading(0).trailing(0).top(0).bottom(0)
        collectionView.backgroundColor = DefaultColorsProvider.containerBackground3
        collectionView.delegate = self
        collectionView.dataSource = self
       
        }
    
    override func contentRequestDidSuccess(with content: [Company]) {
        self.collectionView.reloadData()
    


}
}
extension AllCompaniesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: AllCompanyCollectionViewCell.self, for: indexPath)
        let item = self.items[indexPath.item]
        cell.checkboxView.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
        cell.checkboxView.tag = indexPath.row
        cell.titleLabel.text = item.title
        cell.imageView.sd_setImage(with: item.imageURL)
        cell.checkboxView.isChecked =  self.selectedCategories.contains(item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    @objc func action(sender: UIButton){
        let index = sender.tag
        let item = items[index]
        if self.selectedCategories.contains(item){
            self.selectedCategories.remove(at: selectedCategories.firstIndex(of: item)!)
        } else {
            self.selectedCategories.append(item)
        }
        self.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
    }
}

extension AllCompaniesViewController {
    func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: AllCompanyCollectionViewCell.self)
        
        return collectionView
    }
    
    func generateLayout() -> UICollectionViewLayout {
         //1
        let itemSize = NSCollectionLayoutSize(
           widthDimension: .fractionalWidth(1.0),
           heightDimension: .fractionalHeight(1.0))
         let ItemSpace = NSCollectionLayoutItem(layoutSize: itemSize)
        ItemSpace.contentInsets = NSDirectionalEdgeInsets(
          top: 28,
          leading: 8,
          bottom: 28,
          trailing: 8)
         //2
         let groupSize = NSCollectionLayoutSize(
           widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.45))
         let group = NSCollectionLayoutGroup.horizontal(
           layoutSize: groupSize,
           subitem: ItemSpace,
           count: 3)
        group.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
         //3
         let section = NSCollectionLayoutSection(group: group)
         let layout = UICollectionViewCompositionalLayout(section: section)
         return layout
       
    }
    func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    @objc func backAction(_ sender: UIButton) {
        let _ = navigationController?.popViewController(animated: true)
    }
}



