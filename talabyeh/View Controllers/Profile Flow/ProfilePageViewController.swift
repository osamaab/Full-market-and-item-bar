//
//  ProfilePageViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/25/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

/**
 The Profile view controller acts as a generic view controller displaying information on the header, with menu items can be actionable
 */
class ProfilePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var headerInfo: ProfileHeaderInfo
    var menuItems: [ProfileMenuItem]
    
    
    fileprivate lazy var editMenuItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "edit"), style: .plain, target: self, action: #selector(editButtonTapped))
    fileprivate let profileView = ProfilePageView()
    
    
    var editAction: ActionBlock? {
        didSet {
            if self.editAction != nil {
                navigationItem.rightBarButtonItem = editMenuItem
            } else {
                navigationItem.rightBarButtonItem = nil
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    init(headerInfo: ProfileHeaderInfo, menuItems: [ProfileMenuItem]){
        self.headerInfo = headerInfo
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = DefaultColorsProvider.background
                
        profileView.nameLabel.text = headerInfo.title
        profileView.emailLabel.text = headerInfo.subtitle
        profileView.phoneNumberLabel.text = headerInfo.subtitle2
        
        profileView.emailLabel.isHidden = headerInfo.subtitle == nil
        profileView.phoneNumberLabel.isHidden = headerInfo.subtitle2 == nil

        
        profileView.listTableView.register(cellClass: ProfileTableViewCell.self)
        profileView.listTableView.delegate = self
        profileView.listTableView.dataSource = self
    }
    
    /**
     The current implementation calls the action associated with the item, subclasses may execute different actions based on the given item
     */
    func didSelect(item: ProfileMenuItem){
        item.action?()
    }
    
    @objc func editButtonTapped(){
        self.editAction?()
    }
}


extension ProfilePageViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellClass: ProfileTableViewCell.self, for: indexPath)
        let item = menuItems[indexPath.row]
        
        
        cell.label.text = item.title
        
        let icon = item.image
        
        if isLight {
            cell.icon.image = icon
        } else {
            cell.icon.image = icon
            cell.icon.image = cell.icon.image?.withRenderingMode(.alwaysTemplate)
            cell.icon.tintColor = DefaultColorsProvider.text
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelect(item: menuItems[indexPath.row])
    }
}
