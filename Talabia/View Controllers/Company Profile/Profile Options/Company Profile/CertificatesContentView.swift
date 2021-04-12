//
//  CertificatesContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 14/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

/**
 The view consists of sections, each section contains a list of small item details view
 */
class CertificatesContentView: BasicViewWithSetup {
    
    let sectionKind = "header"
    
    let titleView: LabelView = .init(title: "Certifications / Account level", icon: UIImage(named: "clock_small"))
    
    let uploadView = UploadCertificateView()
    let levelsTitleLabel: UILabel = .init()
    

    lazy var collectionView: UICollectionView = makeCollectionView()
    
    override func setup() {
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        subviewsPreparedAL {
            titleView
            uploadView
            levelsTitleLabel
            collectionView
        }
        
        levelsTitleLabel.text = "Levels"
        levelsTitleLabel.textColor = DefaultColorsProvider.textSecondary1
        levelsTitleLabel.font = .font(for: .bold, size: 16)
        
        titleView.top(0).leading(0).trailing(0)
        levelsTitleLabel.leading(0).trailing(0)
        uploadView.leading(0).trailing(0)
        
        uploadView.Top == titleView.Bottom + 15
        
        levelsTitleLabel.Top == uploadView.Bottom + 20
        collectionView.Top == levelsTitleLabel.Bottom + 15
        
        collectionView.leading(0).trailing(0).bottom(0)
        collectionView.reloadData()
    }
}

extension CertificatesContentView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: ItemCell.self, for: indexPath)
        cell.titleLabel.text = "Little facts about cats..."
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == sectionKind {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TintedLabelCollectionReusableView.identifier, for: indexPath) as! TintedLabelCollectionReusableView
            view.titleLabel.text = "Cat Facts 101"
            return view
        }
        
        return UICollectionReusableView()
    }
}

extension CertificatesContentView {
    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(cellClass: ItemCell.self)
        collectionView.register(TintedLabelCollectionReusableView.self, forSupplementaryViewOfKind: sectionKind, withReuseIdentifier: TintedLabelCollectionReusableView.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(20))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(5)
        
        
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: sectionKind, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 0, bottom: 20, trailing: 0)
        section.boundarySupplementaryItems = [
            headerItem
        ]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 15
        if #available(iOS 14.0, *) {
            configuration.contentInsetsReference = .safeArea
            
        }
        
        layout.configuration = configuration
        
        return layout
    }
}

extension CertificatesContentView {
    class ItemCell: UICollectionViewCell {
        
        let imageView: UIImageView = .init()
        let titleLabel: UILabel = .init()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setup()
        }
        
        func setup(){
            subviewsPreparedAL {
                imageView
                titleLabel
            }
            
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = DefaultColorsProvider.tintPrimary
            
            titleLabel.font = .font(for: .light, size: 14)
            titleLabel.textColor = DefaultColorsProvider.textSecondary1
            
            imageView.leading(0).width(10).height(10).centerVertically()
            titleLabel.leading(15).trailing(0).centerVertically()
        }
    }
}

