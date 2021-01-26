//
//  SelectDistributorViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 22/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia



class SelectDistributorViewController: UIViewController {
    
    /**
     This controls the apperance of the cells, distributor existing will appear as a regular white background color, while the external will appear more like placeholder picker colored background.
     */
    enum ListType {
        case existing
        case external
    }
    
    lazy var headerView: SortAndFilterCollectionReusableView = .init()
    lazy var collectionView: UICollectionView = makeCollectionView()
    lazy var saveView: BottomNextButtonView = .init(title: "Save")
    
    let footerSectionKind = "footerKind"
    let listType: ListType
    
    var selectedIndexPath: IndexPath?
    
    init(listType: ListType){
        self.listType = listType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.subviewsPreparedAL {
            headerView
            collectionView
            saveView
        }
        
        headerView.Top == view.safeAreaLayoutGuide.Top + 20
        headerView.leading(20).trailing(20)
        
        collectionView.Top == headerView.Bottom
        collectionView.leading(0).trailing(0)
        
        saveView.Top == collectionView.Bottom
        saveView.leading(0).trailing(0).bottom(0)
        
        collectionView.contentInset.top = 10
        collectionView.contentInset.bottom = 10
    }
}

extension SelectDistributorViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: DistributerCollectionViewCell.self, for: indexPath)
        if indexPath == selectedIndexPath {
            cell.update(style: .selected)
        } else {
            cell.update(style: listType == .external ? .customTinted(DefaultColorsProvider.containerBackground1) : .regular)
        }
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == self.footerSectionKind {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TintedLabelCollectionReusableView.identifier, for: indexPath) as! TintedLabelCollectionReusableView
            
            view.title = "Request distributor"
            view.backgroundColor = DefaultColorsProvider.containerBackground1
            view.titleLabel.font = .font(for: .semiBold, size: 16)
            view.titleLabel.textColor = DefaultColorsProvider.backgroundPrimary
            view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

            return view
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        self.collectionView.reloadData()
    }
}

extension SelectDistributorViewController {
    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(cellClass: DistributerCollectionViewCell.self)
        collectionView.register(TintedLabelCollectionReusableView.self, forSupplementaryViewOfKind: footerSectionKind, withReuseIdentifier: TintedLabelCollectionReusableView.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(90))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)

        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        group.interItemSpacing = .fixed(10)
        
        
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 20, leading: 0, bottom: 5, trailing: 0)
        
        // add footer for request distributor
        if self.listType == .existing {
            let footerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(90)), elementKind: footerSectionKind, alignment: .bottom)
            footerItem.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)

            section.boundarySupplementaryItems = [
                footerItem
            ]
        }
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        if #available(iOS 14.0, *) {
            configuration.contentInsetsReference = .safeArea
        }
        
        layout.configuration = configuration
        
        return layout
    }
}
