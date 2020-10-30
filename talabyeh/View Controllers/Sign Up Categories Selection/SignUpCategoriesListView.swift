//
//  SignUpCategoriesListView.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/14/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import LanguageManager_iOS
import Stevia

class SignUpCategoriesListView: UIView {


    let backButton = UIButton()
    let catgoryLabel = UILabel()
    let welcomeLabel = UILabel()
    let headerImage = UIImageView()
    let informativeLabel = UILabel()
    let categoriesCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let bottomView = UIView()
    let nextButton = UIButton()
    
    convenience init() {
        
        self.init(frame:CGRect.zero)
        backgroundColor = UIColor.systemBackground
        
        defaultLayout()

    }
    
    
    final private func defaultLayout(){
        
        subviews(backButton)
        subviews(catgoryLabel)
        subviews(welcomeLabel)
        subviews(headerImage)
        subviews(informativeLabel)
        subviews(categoriesCollectionView)
        subviews(bottomView)
        
        
        self.semanticContentAttribute = LanguageManager.shared.currentLanguage == .ar ? .forceRightToLeft : .forceLeftToRight
        
        backButton.setImage(UIImage(named: "Path 2586"), for: .normal)
        
        if LanguageManager.shared.currentLanguage == .ar{
            backButton.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        
        backButton.leading(16)/*.top(30)*/.height(13).width(22)
        backButton.Top == self.safeAreaLayoutGuide.Top + 22

        
        catgoryLabel.text = "Category".localiz()
        catgoryLabel.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(17, .heavy) : getEnglishFont(17, .semiBold)
        catgoryLabel.textColor = UIColor(named: AdaptiveColors.darkGrey.rawValue)
        catgoryLabel.textAlignment = .center
        
        catgoryLabel/*.top(30)*/.height(20).centerHorizontally().width(100)
        //signUpLabel.Top == self.safeAreaLayoutGuide.Top + 22
        catgoryLabel.CenterY == backButton.CenterY
        
        welcomeLabel.text = "Welcome to TALABYEH".localiz()
        welcomeLabel.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(22, .bold) : getEnglishFont(22, .bold)
        welcomeLabel.textColor = UIColor(named: AdaptiveColors.green.rawValue)
        welcomeLabel.textAlignment = .justified
        
        welcomeLabel.height(26).leading(16)
        welcomeLabel.Top == catgoryLabel.Bottom + 17
        
        headerImage.image = UIImage(named: "Group 2709")
        headerImage.leading(16).trailing(16).height(33)
        headerImage.Top == welcomeLabel.Bottom + 9
        
        
        informativeLabel.text = "Please choose the category of resellers You can serve".localiz()
        informativeLabel.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(16, .regular) : getEnglishFont(16, .medium)
        informativeLabel.textColor = UIColor(named: AdaptiveColors.green.rawValue)
        informativeLabel.textAlignment = LanguageManager.shared.currentLanguage == .en ? .left : .right
        informativeLabel.numberOfLines = 2
        
        informativeLabel/*.height(39)*/.leading(16)//.width(195)
        informativeLabel.Top == headerImage.Bottom + 14
        informativeLabel.Trailing == catgoryLabel.Trailing
        
        categoriesCollectionView.backgroundColor = UIColor.systemBackground
        
        categoriesCollectionView.trailing(16).leading(16)
        categoriesCollectionView.Top == informativeLabel.Bottom + 18
        
        // Bottom View
        
        bottomView.subviews(nextButton)
        
        //nextButton.backgroundColor = #colorLiteral(red: 0.5764705882, green: 0.8352941176, blue: 0, alpha: 1)
        nextButton.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.3607843137, blue: 0.1960784314, alpha: 1)
        nextButton.layer.borderWidth = 1
        nextButton.top(10).width(250).height(44).centerHorizontally()
        nextButton.setTitleColor(#colorLiteral(red: 0.06666666667, green: 0.3607843137, blue: 0.1960784314, alpha: 1), for: .normal)
        nextButton.setTitle("Next".localiz(), for: .normal)
        nextButton.titleLabel?.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(16, .regular) : getEnglishFont(16, .medium)
        nextButton.layer.cornerRadius = 20
        if LanguageManager.shared.currentLanguage == .ar{
            nextButton.contentVerticalAlignment = .top
        }
        
        bottomView.backgroundColor = Constants.lightGreen
        bottomView.leading(0).trailing(0).bottom(0).height(83)
        bottomView.Top == categoriesCollectionView.Bottom
        
    }

}
