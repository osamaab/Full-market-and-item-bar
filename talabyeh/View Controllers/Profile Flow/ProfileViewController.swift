//
//  ProfilePageViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/25/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

/**
 The Profile view controller acts as a generic view controller displaying information on the header, with menu items can be actionable
 */
class ProfileViewController<UserType: UserModelType>: ContentViewController<UserType>, UICollectionViewDataSource, UICollectionViewDelegate {
    
    struct ProfileDefaultContentRepository: ContentRepositoryType {
        enum InternalErrorType: String, Error {
            case unAuthenticated
        }
        
        typealias ContentType = UserType
        
        func requestContent(completion: @escaping ContentRequestCompletion<UserType>) {
            guard DefaultPreferencesController.shared.userType != nil else {
                fatalError("Can't initialize a profile without a user type!")
            }
            
            guard let currentProfile = DefaultAuthenticationManager.shared.authProfile else {
                completion(.failure(InternalErrorType.unAuthenticated))
                return
            }
            
            guard let castedProfile = currentProfile.associatedData as? UserType else {
                fatalError("Profile: Expected  \(String(describing: UserType.self)) but found a \(String(describing: currentProfile.associatedData))")
            }
            
            completion(.success(castedProfile))
        }
    }
    
    var menuItems: [ProfileMenuItem] = []
    
    lazy var collectionView: UICollectionView = createCollectionView()
    lazy var headerView: ProfileHeaderView = .init()
    
    init(){
        super.init(contentRepository: ProfileDefaultContentRepository())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func setupViewsBeforeTransitioning() {
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        view.subviewsPreparedAL {
            headerView
            collectionView
        }
        
        headerView.Top == view.safeAreaLayoutGuide.Top
        headerView.leading(0).trailing(0)
        
        collectionView.Top == headerView.Bottom
        collectionView.leading(0).trailing(0).bottom(0)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    fileprivate func setupItems(with result: Result<UserType, Error>) -> [ProfileMenuItem] {
        if case .failure(let error) = result,
           let asInteranl = error as? ProfileDefaultContentRepository.InternalErrorType,
           asInteranl == .unAuthenticated {
        
            
            let loginMenuItem = ProfileMenuItem(identifier: .login, title: "Login", image: UIImage(named: "next-selected"), style: .normal) {
                AppDelegate.shared.router.trigger(.chooseUserType)
            }
            
            return [loginMenuItem] + setupItems()
        }
        
        return setupItems()
    }
    
    func setupItems() -> [ProfileMenuItem] {
        []
    }
    
    override func contentRequestDidFinish(with result: Result<UserType, Error>) {
        self.menuItems = setupItems(with: result)
        self.collectionView.reloadData()
    }
    
    override func contentRequestDidFail(with error: Error) {
        if let internalError = error as? ProfileDefaultContentRepository.InternalErrorType, internalError == .unAuthenticated {
            
            // handle unauthenticated state..
            self.headerView.titleLabel.text = "Welcome to Talabeyah"
            self.headerView.subtitleLabel.text = "Login to continue"
            self.headerView.tertiaryLabel.text = ""
            self.headerView.imageView.image = nil
            
            self.transition(to: .initial)
        }
    }
    
    func performAction(for item: ProfileMenuItem){
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellClass: ProfileMenuItemCollectionViewCell.self, for: indexPath)
        let item = menuItems[indexPath.item]
        
        cell.imageView.image = item.image
        cell.titleLabel.text = item.title
        cell.style = item.style
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = menuItems[indexPath.item]
        
        if let action = item.action {
            action()
        } else {
            self.performAction(for: item)
        }
    }
}

extension ProfileViewController {
    func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createCollectionViewLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellClass: ProfileMenuItemCollectionViewCell.self)
        return collectionView
    }
    
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let itemHeightDimension: NSCollectionLayoutDimension = .absolute(60)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: itemHeightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: itemHeightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
