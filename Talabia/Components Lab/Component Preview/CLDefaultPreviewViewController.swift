//
//  CLDefaultPreviewViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 24/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

/**
 A view controller which provides a card view, with
 */
class CLDefaultPreviewViewController: UIViewController {
    
    let contentView: UIView
    let cardView: CLComponentContainerView
    
    init(contentView: UIView, title: String){
        self.contentView = contentView
        self.cardView = .init(title: title, contentView: contentView)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        view.subviewsPreparedAL {
            cardView
        }
        
        cardView.Top == view.safeAreaLayoutGuide.Top + 25
        cardView.leading(20).trailing(20)
    }
}
