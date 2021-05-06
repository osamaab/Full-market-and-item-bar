//
//  SettingsViewController.swift
//  Talabia
//
//  Created by Osama Abu hdba on 02/05/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class SettingsViewController<ProfileUser: UserModelType>: ContentViewController<ProfileUser>, UICollectionViewDataSource, UICollectionViewDelegate {
    
    lazy var collectionView: UICollectionView = createCollectionView()
    lazy var topView: ProfileSettingView = .init()
    var menuItems: [ProfileMenuItem] = []
    var isSelected = false
    struct ProfileDefaultContentRepository: ContentRepositoryType {
        enum InternalErrorType: String, Error {
            case unAuthenticated
        }
        
        typealias ContentType = ProfileUser
        
        func requestContent(completion: @escaping ContentRequestCompletion<ProfileUser>) {
            guard DefaultPreferencesController.shared.userType != nil else {
                fatalError("Can't initialize a profile without a user type!")
            }
            
            guard let currentProfile = DefaultAuthenticationManager.shared.authProfile else {
                completion(.failure(InternalErrorType.unAuthenticated))
                return
            }
            
            guard let castedProfile = currentProfile.associatedData as? ProfileUser else {
                return
            }
            
            completion(.success(castedProfile))
        }
    }
    override func setupViewsBeforeTransitioning() {
        title = "Settings"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), action: {            self.navigationController?.popViewController(animated: true)
        })
        view.subviewsPreparedAL {
            topView
            collectionView
        }
        topView.Top == view.safeAreaLayoutGuide.Top + 20
        topView.leading(8).trailing(8)
        topView.Bottom == collectionView.Top
        collectionView.Top == topView.Bottom
        collectionView.leading(10).trailing(10).bottom(0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        
        topView.LanguageButton.add(event: .touchUpInside){ [unowned self] in
            if self.isSelected == true {
                self.topView.LanguageButton.setTitle("Arabic", for: .normal)
                self.isSelected = !self.isSelected
            }else {
                self.topView.LanguageButton.setTitle("English", for: .normal)
                self.isSelected = !self.isSelected
                
            }
        }
        
    }
    
    fileprivate func setupItems(with result: Result<ProfileUser, Error>) -> [ProfileMenuItem] {
        if case .failure(let error) = result,
           let asInteranl = error as? ProfileDefaultContentRepository.InternalErrorType,
           asInteranl == .unAuthenticated {

            
            let loginMenuItem = ProfileMenuItem(identifier: .login, title: "Login", image: UIImage(named: "next-selected"), style: .normal) {
                AppDelegate.shared.router.trigger(.chooseSignInMethod)
            }
            
            return [loginMenuItem] + setupItems()
        }
        
        return  setupItems()
    }
    override func contentRequestDidFinish(with result: Result<ProfileUser, Error>) {
        self.menuItems = setupItems(with: result)
        self.collectionView.reloadData()
        if case .success( _) = result {
            view.addSubview(topView)
            
        }
    }
    func setupItems() -> [ProfileMenuItem] {
        []
    }
    func performAction(for item: ProfileMenuItem.Identifier){
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menuItems.count
    }
    init(){
        super.init(contentRepository: ProfileDefaultContentRepository())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: ProfileMenuItemCollectionViewCell.self, for: indexPath)
        let item = menuItems[indexPath.item]
        cell.imageView.image = item.image
        cell.titleLabel.text = item.title
        cell.worningImageView.isHidden = true
        cell.style = item.style
        cell.backgroundColor = .white
        cell.titleLabel.font = .font(for: .regular, size: 17)
        cell.arrowImageView.image = UIImage(named: "right-arrow")
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = menuItems[indexPath.item]
        if let action = item.action {
            action()
        } else {
            self.performAction(for: item.identifier)
        }
    }
}
extension SettingsViewController {
    func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createCollectionViewLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: ProfileMenuItemCollectionViewCell.self)
        return collectionView
    }
    
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let itemHeightDimension: NSCollectionLayoutDimension = .absolute(44)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: itemHeightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: itemHeightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        
        return UICollectionViewCompositionalLayout(section: section)
    }    
}
