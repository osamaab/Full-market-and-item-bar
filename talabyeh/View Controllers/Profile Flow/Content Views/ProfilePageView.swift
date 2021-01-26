//
//  ProfilePageView.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/25/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia
import LanguageManager_iOS

class ProfilePageView: UIView {

    let personalInfoView = UIView()
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let phoneNumberLabel = UILabel()
    let listTableView = UITableView()
    
    convenience init() {
        self.init(frame:CGRect.zero)
        defaultLayout()
        customizeApperance()
    }
    
    final private func defaultLayout() {
        
        subviews {
            personalInfoView
            listTableView
        }
        
        personalInfoView.subviews {
            profileImageView
            nameLabel
            emailLabel
            phoneNumberLabel
        }


        backgroundColor = DefaultColorsProvider.backgroundSecondary

        personalInfoView.backgroundColor = DefaultColorsProvider.backgroundPrimary
        nameLabel.textColor = DefaultColorsProvider.textPrimary1
        listTableView.backgroundColor = DefaultColorsProvider.backgroundSecondary
        emailLabel.textColor = !isLight ? DefaultColorsProvider.backgroundPrimary : #colorLiteral(red: 0.4980392157, green: 0.5647058824, blue: 0.5098039216, alpha: 1)
        phoneNumberLabel.textColor = !isLight ? DefaultColorsProvider.backgroundPrimary : #colorLiteral(red: 0.4980392157, green: 0.5647058824, blue: 0.5098039216, alpha: 1)
        profileImageView.layer.borderColor =  #colorLiteral(red: 0.4980392157, green: 0.5647058824, blue: 0.5098039216, alpha: 1) //


        nameLabel.font = .font(for: .heavy, size: 22)
        emailLabel.font = .font(for: .heavy, size: 16)

        
        personalInfoView.leading(0).trailing(0).height(259.91)
        personalInfoView.Top == safeAreaLayoutGuide.Top
        
        listTableView.leading(0).trailing(0).bottom(0)
        listTableView.Top == personalInfoView.Bottom
        
        profileImageView.height(106).width(106).centerHorizontally().top(22.94) //
        profileImageView.layer.borderWidth = 2 //
        profileImageView.layer.cornerRadius = 53//profileImageView.layer.frame.width / 2
        
        nameLabel.centerHorizontally().height(26)
        nameLabel.Top == profileImageView.Bottom + 10
        
        emailLabel.height(19).centerHorizontally()
        emailLabel.Top == nameLabel.Bottom + 10.41
        
        phoneNumberLabel.font = .font(for: .regular, size: 13)
        phoneNumberLabel.height(15).centerHorizontally()
        phoneNumberLabel.Top == emailLabel.Bottom + 14.41
    }
    
    
    fileprivate func customizeApperance(){
        listTableView.separatorStyle = .none
        
        let tableheaderView = UIView(frame: CGRect(x: 0, y: 0, width: listTableView.frame.size.width, height: 18.76))
        tableheaderView.backgroundColor = DefaultColorsProvider.backgroundSecondary
        listTableView.tableHeaderView = tableheaderView
        
        personalInfoView.layer.borderColor = !isLight  ? #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1) : #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
       
        if isLight {
            personalInfoView.layer.borderWidth = 1
            personalInfoView.layer.cornerRadius = 15
            personalInfoView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            personalInfoView.dropShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), opacity: 1, offSet: .zero, radius: 10)
        }
    }
}



