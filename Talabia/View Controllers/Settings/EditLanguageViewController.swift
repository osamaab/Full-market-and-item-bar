//
//  EditLanguageViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 17/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

protocol EditLanguageViewControllerDelegate: class {
    func editLanguageViewController(_ sender: EditLanguageViewController, didFinishWith language: LanguageItem)
}

enum LanguageItem: String, Hashable, Equatable, CaseIterable {
    case english
    case arabic
    
    var name: String {
        rawValue.capitalizingFirstLetter()
    }
}

class EditLanguageViewController: ContentViewController<[LanguageItem]> {

    lazy var collectionView: UICollectionView = createCollectionView()
    lazy var bottomSaveView: BottomNextButtonView = .init(title: "Save")
    
    weak var delegate: EditLanguageViewControllerDelegate?

    var selectedLanguage: LanguageItem = .english
    
    convenience init(){
        self.init(contentRepository: ConstantContentRepository<[LanguageItem]>(content: LanguageItem.allCases))
    }
    
    override func setupViewsBeforeTransitioning() {
        
        navigationItem.title = "Edit Language"
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL { () -> [UIView] in
            collectionView
            bottomSaveView
        }
        
        collectionView.leading(0).trailing(0)
        collectionView.Top == view.safeAreaLayoutGuide.Top
        
        bottomSaveView.bottom(0).leading(0).trailing(0)
        bottomSaveView.Top == collectionView.Bottom
        
        bottomSaveView.nextButton.add(event: .touchUpInside){ [unowned self] in
            self.delegate?.editLanguageViewController(self, didFinishWith: self.selectedLanguage)
        }
    }
    
    override func contentRequestDidSuccess(with content: [LanguageItem]) {
        collectionView.reloadData()
    }
}

extension EditLanguageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        content?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: OptionCollectionViewCell.self, for: indexPath)
        let item = unwrappedContent[indexPath.item]
        
        cell.titleLabel.text = item.name
        cell.checkbox.isSelected = item == selectedLanguage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedLanguage = unwrappedContent[indexPath.item]
        self.collectionView.reloadData()
    }
}

extension EditLanguageViewController {
    func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createCollectionViewLayout())
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: OptionCollectionViewCell.self)
        return collectionView
    }
    
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let itemHeightDimension: NSCollectionLayoutDimension = .absolute(50)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: itemHeightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: itemHeightDimension)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)

        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
