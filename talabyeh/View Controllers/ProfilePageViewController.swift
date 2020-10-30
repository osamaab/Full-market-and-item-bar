//
//  ProfilePageViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/25/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit

class ProfilePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    let profileView = ProfilePageView()
    
    let listLabels = ["Change Password".localiz(),"Payment".localiz(),"Orders".localiz(), "Store Location".localiz(), "Full Information".localiz(), "History".localiz()]
    let listImagesNames = ["Group 1447","Group 1450","Group 2759", "Group 1457", "Group 2255" , "Group 2257"]
    
    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileView.backgroundColor = Constants.lightGrey
        profileView.headerLabel.text = "loai elayan"
        profileView.nameLabel.text = "loai elayan"
        profileView.emailLabel.text = "loai@loai.com"
        profileView.phoneNumberLabel.text = "0799034903"
        
        profileView.listTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "Cell")
        profileView.listTableView.delegate = self
        profileView.listTableView.dataSource = self
        let tableheaderView = UIView(frame: CGRect(x: 0, y: 0, width: profileView.listTableView.frame.size.width, height: 18.76 ))
        tableheaderView.backgroundColor = UIColor(named: "Light Grey Adaptive")
        profileView.listTableView.tableHeaderView = tableheaderView
        profileView.listTableView.separatorStyle = .none
        
        profileView.backButton.addTarget(self, action: #selector(backButton), for: .touchUpInside)
        
        

    }
    
    @objc func backButton(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if self.traitCollection.userInterfaceStyle == .light{
            
            profileView.personalInfoView.layer.borderWidth = 1
            profileView.personalInfoView.layer.borderColor = self.traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1) : #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
            profileView.personalInfoView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15)
            
            profileView.personalInfoView.dropShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), opacity: 1, offSet: .zero, radius: 10, scale: true)
        }
//        profileView.personalInfoView.layer.shadowColor = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)
//        profileView.personalInfoView.layer.shadowOpacity = 1
//        profileView.personalInfoView.layer.shadowOffset = .zero
//        profileView.personalInfoView.layer.shadowRadius = 10
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProfileTableViewCell
        cell.label.text = listLabels[indexPath.row]
        
        if self.traitCollection.userInterfaceStyle == .dark {
            let icon = UIImage(named: listImagesNames[indexPath.row])
            //icon?.withRenderingMode(.alwaysTemplate)
            cell.icon.image = icon
            cell.icon.image = cell.icon.image?.withRenderingMode(.alwaysTemplate) //UIImage(named: listImagesNames[indexPath.row])
            //icon.tintColor = .white
            cell.icon.tintColor = .white
        }else{
            cell.icon.image = UIImage(named: listImagesNames[indexPath.row])
            
        }
//        if self.traitCollection.userInterfaceStyle == .dark {
//            cell.icon.image?.withRenderingMode(.alwaysTemplate)
//            cell.icon.tintColor = .white
//        }
        return cell
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{return .lightContent}

}
