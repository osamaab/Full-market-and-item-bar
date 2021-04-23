//
//  ChooseUserViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 07/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia
import XCoordinator


protocol ChooseUserViewControllerDelegate: class {
    func chooseUserViewController(_ sender: ChooseUserViewController, didFinishWith user: UserType)
    func chooseUserViewControllerDidChooseLogin(_ sender: ChooseUserViewController)
    func MainCategoriesPickerViewControllerDidChooseSkip(_ sender: ChooseUserViewController)

}

class ChooseUserViewController: ContentViewController<[APIUserType]> {


    @Injected var preferencesManager: DefaultPreferencesController

    lazy var headerView: AuthHeaderView = .init(elements: [
                                                    .title("Welcome to TALABIA"),
                                                    .subtitle("Let's get started")])
    
    lazy var collectionView: UICollectionView = makeCollectionView()
    lazy var bottomView: chooseUserTypeBottomNextButtonView = .init(title: "Next")
    
    var isSelected: Bool {
        false
    }
    let chooseLanguageButton: ChooseLanguageButton = .init()
    var selectedIndexPath: IndexPath?
    
    weak var delegate: ChooseUserViewControllerDelegate?
    
    convenience init(){
        self.init(contentRepository: APIContentRepositoryType<GeneralAPI, [APIUserType]>(.userTypes))
    }
    
    override func setupViewsBeforeTransitioning() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log in", action: {
            self.delegate?.chooseUserViewControllerDidChooseLogin(self)
        })
        
        self.navigationItem.rightBarButtonItem?.tintColor = DefaultColorsProvider.tintPrimary
        
        self.navigationItem.rightBarButtonItem?.tintColor = DefaultColorsProvider.tintPrimary
        
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            chooseLanguageButton
            headerView
            collectionView
            bottomView
        }
        
        chooseLanguageButton.trailing(20)
        chooseLanguageButton.height(48)
        //        chooseLanguageButton.CenterY == headerView.CenterY
        chooseLanguageButton.Top == view.safeAreaLayoutGuide.Top + 45
        
        headerView.subtitleLabel.textColor = DefaultColorsProvider.textSecondary1
        
        bottomView.nextButton.backgroundColor = DefaultColorsProvider.tintSecondary
        bottomView.nextButton.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        
        
        headerView.Top == view.safeAreaLayoutGuide.Top + 45
        headerView.leading(20).trailing(20)
        
        collectionView.Top == headerView.Bottom + 20
        collectionView.leading(0).trailing(0)
        
        bottomView.Top == collectionView.Bottom
        bottomView.bottom(0).leading(0).trailing(0)
        
        bottomView.nextButton.add(event: .touchUpInside){ [unowned self] in
            if let selectedIndexPath = self.selectedIndexPath, let userType = self.state.content?[selectedIndexPath.item] {
                
                self.delegate?.chooseUserViewController(self, didFinishWith: UserType(rawValue: userType.id)!)
            }
        }
    }
    
    override func contentRequestDidSuccess(with content: [APIUserType]) {
        
        let selectedUserTypeFromPrefenreces = self.preferencesManager.userType
        
        
        
        if let selected = (content.firstIndex { $0.id == self.preferencesManager.userType?.rawValue }) {
            self.selectedIndexPath = IndexPath(item: selected, section: 0)
        }
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
        
        cell.setSelected(indexPath == selectedIndexPath, animated: true)
        
        if indexPath == selectedIndexPath {
            cell.checkedMarkImage.image = UIImage(named: "checkbox_selected")
        } else {
            cell.checkedMarkImage.image = UIImage(named: "check_empty")
        }
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

