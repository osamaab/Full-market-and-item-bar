//
//  CPMenuItemCollectionViewCellViewController.swift
//  WININ
//
//  Created by Hussein Work on 01/03/2021.
//  Copyright © 2021 The AREA. All rights reserved.
//

import UIKit

class CPMenuItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .font(for: .demiBold, size: 18)
        backgroundColor = UIColor.appCyan.withAlphaComponent(0.4)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}
