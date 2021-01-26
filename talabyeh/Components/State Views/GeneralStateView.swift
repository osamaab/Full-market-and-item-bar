//
//  GeneralStateView.swift
//  talabyeh
//
//  Created by Hussein Work on 03/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class GeneralStateView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = AdaptiveColorsProvider.textPrimary1
        label.font = .font(for: .bold, size: 21)
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = AdaptiveColorsProvider.textSecondary1
        label.font = .font(for: .bold, size: 15)
        return label
    }()
    
    let retryButton: ActionButton = .init()
    
    var onButtonTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    fileprivate func setup(){
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, subtitleLabel, retryButton])
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.setCustomSpacing(20, after: subtitleLabel)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.setCustomSpacing(30, after: imageView)
        stackView.setCustomSpacing(30, after: subtitleLabel)
        
        addSubview(stackView)
        
        imageView.Width == imageView.Height
        imageView.width(150)
        
        stackView.centerInContainer().left(20)
        stackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor).isActive = true
        
        retryButton.layer.cornerRadius = 6
        retryButton.contentEdgeInsets = .init(top: 8, left: 25, bottom: 8, right: 25)
        retryButton.clipsToBounds = true
        retryButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc  func buttonTapped(){
        self.onButtonTap?()
    }
}

extension GeneralStateView: CLComponentPreview {
    static var groupIdentifier: CLComponentGroupIdentifier {
        .general
    }
    
    static func render(in context: CLComponentPreviewContext) {
        let view = GeneralStateView()
        
        view.titleLabel.text = "Title Goes Here"
        view.subtitleLabel.text = "Additional Description may go here as well"
        view.retryButton.setTitle("Retry", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        context.containerView.addSubview(view)
        
        view.top(20).bottom(20)
        view.leading(35)
        view.centerHorizontally()
    }
}
