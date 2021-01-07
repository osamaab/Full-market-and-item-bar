//
//  ChooseUserViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 07/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class ChooseUserViewController: ContentViewController<[UserType]> {
    
    lazy var headerView: AuthHeaderView = .init(elements: [
                                                    .title("Welcome to TALABIA"),
                                                    .subtitle("Let's get started")])
    
    lazy var collectionView: UICollectionView = makeCollectionView()
    lazy var bottomView: BottomNextButtonView = .init(title: "Next")
    
    
    var selectedIndexPath: IndexPath?
    
    
    convenience init(){
        self.init(contentRepository: APIContentRepositoryType<GeneralAPI, [UserType]>(.userTypes))
    }
    
    override func setupViewsBeforeTransitioning() {
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            headerView
            collectionView
            bottomView
        }
        
        headerView.subtitleLabel.textColor = DefaultColorsProvider.textSecondary1
        
        bottomView.backgroundColor = DefaultColorsProvider.tintPrimary
        bottomView.nextButton.backgroundColor = DefaultColorsProvider.tintSecondary
        bottomView.nextButton.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)

        
        headerView.Top == view.safeAreaLayoutGuide.Top + 45
        headerView.leading(20).trailing(20)
        
        collectionView.Top == headerView.Bottom + 20
        collectionView.leading(0).trailing(0)
        
        bottomView.Top == collectionView.Bottom
        bottomView.bottom(0).leading(0).trailing(0)
    }

    override func contentRequestDidSuccess(with content: [UserType]) {
        self.collectionView.reloadData()
    }
}

extension ChooseUserViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        (content ?? []).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = content![indexPath.item]
        let cell = collectionView.dequeueCell(cellClass: UserTypeCollectionViewCell.self, for: indexPath)
        
        cell.titleLabel.text = item.name
        cell.imageView.sd_setImage(with: item.logo)
        
        cell.setSelected(indexPath == selectedIndexPath, animated: false)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        self.collectionView.reloadData()
    }
}

extension ChooseUserViewController {
    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(cellClass: UserTypeCollectionViewCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        section.interGroupSpacing = 15
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        if #available(iOS 14.0, *) {
            configuration.contentInsetsReference = .safeArea
        }
        
        layout.configuration = configuration
        
        return layout
    }
}

