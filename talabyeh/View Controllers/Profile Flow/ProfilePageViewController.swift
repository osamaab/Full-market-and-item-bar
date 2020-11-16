//
//  ProfilePageViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/25/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit

enum ProfileMenu: String, CaseIterable {
    case changePassword
    case payment
    case orders
    case location
    case information
    case history
    
    var title: String {
        switch self {
        case .changePassword:
            return "Change Password".localiz()
        case .payment:
            return "Payment".localiz()
        case .orders:
            return "Orders".localiz()
        case .location:
            return "Store Location".localiz()
        case .information:
            return "Full Information".localiz()
        case .history:
            return "History".localiz()
        }
    }
    
    var image: UIImage? {
        let imageName: String
        switch self {
        case .changePassword:
            imageName = "Group 1447"
        case .payment:
            imageName = "Group 1450"
        case .orders:
            imageName = "Group 2759"
        case .location:
            imageName = "Group 1457"
        case .information:
            imageName = "Group 2255"
        case .history:
            imageName = "Group 2257"
        }
        
        return UIImage(named: imageName)
    }
}

class ProfilePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let profileView = ProfilePageView()
    var menuItems: [ProfileMenu] = ProfileMenu.allCases
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuItems.remove(at: menuItems.firstIndex(of: .information)!)
        
        profileView.backgroundColor = Constants.lightGrey
        profileView.nameLabel.text = "loai elayan"
        profileView.emailLabel.text = "loai@loai.com"
        profileView.phoneNumberLabel.text = "0799034903"
        
        profileView.listTableView.register(cellClass: ProfileTableViewCell.self)
        profileView.listTableView.delegate = self
        profileView.listTableView.dataSource = self
        profileView.listTableView.separatorStyle = .none
        
        let tableheaderView = UIView(frame: CGRect(x: 0, y: 0, width: profileView.listTableView.frame.size.width, height: 18.76))
        tableheaderView.backgroundColor = UIColor(named: "Light Grey Adaptive")
        profileView.listTableView.tableHeaderView = tableheaderView
        
        
        profileView.personalInfoView.layer.borderColor = !isLight  ? #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1) : #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
       
        if isLight {
            profileView.personalInfoView.layer.borderWidth = 1
            profileView.personalInfoView.layer.cornerRadius = 15
            profileView.personalInfoView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            profileView.personalInfoView.dropShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), opacity: 1, offSet: .zero, radius: 10, scale: true)
        }
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
            cell.icon.tintColor = .white
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newDistributersViewController = NewDistributerViewController()
        self.navigationController?.pushViewController(newDistributersViewController, animated: true)
    }
}
