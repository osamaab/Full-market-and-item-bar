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
class ProfileViewController<ProfileUser: UserModelType>: ContentViewController<ProfileUser>, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let preferencesManager = UserDefaultsPreferencesManager.shared
    
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
    
    var menuItems: [ProfileMenuItem] = []
    
    lazy var collectionView: UICollectionView = createCollectionView()
    lazy var headerView: ProfileHeaderView = .init()
    
    init(){
        super.init(contentRepository: ProfileDefaultContentRepository())
    }
    
    override init<R: ContentRepositoryType>(contentRepository: R) where R.ContentType == ContentType {
        super.init(contentRepository: contentRepository)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override func setupViewsBeforeTransitioning() {
       
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        setupNavigationBarRightView()
        
            view.subviewsPreparedAL {
                headerView
                collectionView
            }
    
        headerView.layer.cornerRadius = 13
        headerView.Top == view.safeAreaLayoutGuide.Top
        headerView.leading(0).trailing(0)
        
        collectionView.Top == headerView.Bottom
        collectionView.leading(0).trailing(0).bottom(0)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.reloadData()
        
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
    
    func setupItems() -> [ProfileMenuItem] {
        []
    }
    
    override func contentRequestDidFinish(with result: Result<ProfileUser, Error>) {
        self.menuItems = setupItems(with: result)
        self.collectionView.reloadData()
        
        if case .success(let content) = result {
            self.headerView.titleLabel.text = content.name
            self.headerView.subtitleLabel.text = content.email
            self.headerView.tertiaryLabel.text = content.mobile
            guard let imageUrl = content.imageURL else {
                self.headerView.imageView.image = UIImage(named: "profile_PlaceHolder")
             
                self.headerView.imageView.layer.cornerRadius = headerView.imageView.frame.width / 2
                self.headerView.imageView.contentMode = .scaleToFill
//                self.headerView.imageView.dropShadow(color: .gray,
//                                                     opacity: 0.3,
//                                                       offSet: .init(width: 0, height: 3.4),
//                                                       radius: 3.4)
                self.headerView.imageView.clipsToBounds = true 
                return
            }
//            self.headerView.imageView.image = UIImage(named: "profile_PlaceHolder")
//            self.headerView.imageView.dropShadow(color: .gray,
//                                                 opacity: 0.3,
//                                                   offSet: .init(width: 0, height: 3.4),
//                                                   radius: 3.4)
            
            self.headerView.imageView.layer.cornerRadius = 50
            self.headerView.imageView.contentMode = .scaleAspectFill
            self.headerView.imageView.clipsToBounds = true
            self.headerView.imageView.sd_setImage(with: imageUrl, completed: nil)
        }
    }
    
    override func contentRequestDidFail(with error: Error) {
        if let internalError = error as? ProfileDefaultContentRepository.InternalErrorType, internalError == .unAuthenticated {
            
            // handle unauthenticated state..
            self.headerView.titleLabel.text = "Welcome to Talabeyah"
            self.headerView.subtitleLabel.text = "Login to continue"
            self.headerView.tertiaryLabel.text = ""
            self.headerView.imageView.image = UIImage(named: "profile_PlaceHolder")
            
            self.transition(to: .initial)
        }
    }
    
    func performAction(for item: ProfileMenuItem.Identifier){
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
            self.performAction(for: item.identifier)
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
        let itemHeightDimension: NSCollectionLayoutDimension = .absolute(44)
        
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

extension ProfileViewController {
    private func setupNavigationBarRightView(){
        let deliverToButton = UIButton(type: .custom)
        deliverToButton.setTitle("Log out", for: .normal)
        deliverToButton.frame = CGRect(x: 0, y: 0, width: 60, height: 20)
        deliverToButton.setTitleColor(.white, for: .normal)
        deliverToButton.titleLabel?.font = .font(for: .bold, size: 17)
        deliverToButton.add(event: .touchUpInside) {
        AppDelegate.shared.router.trigger(.logout)
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: deliverToButton)
    }
}
