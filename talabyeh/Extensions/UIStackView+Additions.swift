//
//  UIStackView+Additions.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

@_functionBuilder public struct SubviewsBuilder {
    public static func buildBlock(_ content: UIView...) -> [UIView] {
        return content
    }
}

/**
 Creating a chainable stackview to make life easiere
 */

extension UIStackView {
    @discardableResult
    func alignment(_ alignment: Alignment) -> UIStackView {
        self.alignment = alignment
        return self
    }
    
    @discardableResult
    func distribution(_ distribution: Distribution) -> UIStackView {
        self.distribution = distribution
        return self
    }
    
    @discardableResult
    func spacing(_ spacing: CGFloat) -> UIStackView {
        self.spacing = spacing
        return self
    }
    
    @discardableResult
    func axis(_ axis: NSLayoutConstraint.Axis) -> UIStackView {
        self.axis = axis
        return self
    }
    
    @discardableResult
    func addingArrangedSubviews(_ arrangedSubviews: [UIView]) -> UIStackView {
        arrangedSubviews.forEach {
            self.addArrangedSubview($0)
        }
        
        return self
    }
    
    @discardableResult
    func preparedForAutolayout() -> UIStackView {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    @discardableResult
    func arrangedSubviews(@SubviewsBuilder content: () -> [UIView]) -> UIStackView {
        for sv in content() {
            addArrangedSubview(sv)
            sv.translatesAutoresizingMaskIntoConstraints = false
        }
        return self
    }
}
