//
//  ProfilePageView.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/25/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
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
        backgroundColor = DefaultColorsProvider.background
        defaultLayout()
    }
    
    final private func defaultLayout() {
        
        subviews([personalInfoView, listTableView])

        personalInfoView.backgroundColor = DefaultColorsProvider.background
        
        
        personalInfoView.leading(0).trailing(0).height(259.91)
        personalInfoView.top(0)
        
        listTableView.backgroundColor = UIColor(named: "Light Grey Adaptive")
        listTableView.leading(0).trailing(0).bottom(0)
        listTableView.Top == personalInfoView.Bottom
        
        personalInfoView.subviews([profileImageView, nameLabel, emailLabel, phoneNumberLabel])
        profileImageView.height(106).width(106).centerHorizontally().top(22.94) //
        profileImageView.layer.borderWidth = 2 //
        profileImageView.layer.borderColor =  #colorLiteral(red: 0.4980392157, green: 0.5647058824, blue: 0.5098039216, alpha: 1) //
        profileImageView.layer.cornerRadius = 53//profileImageView.layer.frame.width / 2
        
        nameLabel.font = .font(for: .heavy, size: 22)
        nameLabel.textColor = UIColor(named: "Black Adaptive")
        nameLabel.centerHorizontally().height(26)
        nameLabel.Top == profileImageView.Bottom + 10
        
        emailLabel.font = .font(for: .heavy, size: 16)
        emailLabel.textColor = !isLight ? .white : #colorLiteral(red: 0.4980392157, green: 0.5647058824, blue: 0.5098039216, alpha: 1)
        emailLabel.height(19).centerHorizontally()
        emailLabel.Top == nameLabel.Bottom + 10.41
        
        phoneNumberLabel.font = .font(for: .regular, size: 13)
        phoneNumberLabel.textColor = !isLight ? .white : #colorLiteral(red: 0.4980392157, green: 0.5647058824, blue: 0.5098039216, alpha: 1)
        phoneNumberLabel.height(15).centerHorizontally()
        phoneNumberLabel.Top == emailLabel.Bottom + 14.41
    }
}



