//
//  ExpandableItemCell.swift
//  talabyeh
//
//  Created by Hussein AlRyalat on 11/18/2019.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class ExpandableFolderItemCell: UICollectionViewCell {
    
    var isExpanded = false {
        didSet {
            expansionStateDidChange()
        }
    }
    var isGroup = false {
        didSet {
            expansionStateDidChange()
        }
    }
    
    var title: String? {
        didSet {
            titleDidChange()
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        expansionStateDidChange()
    }
    
    func expansionStateDidChange(){
        if self.isGroup {
            self.backgroundColor = UIColor.lightGray
        } else {
            self.backgroundColor = UIColor.red
        }
    }
    
    func titleDidChange(){
        
    }
}
