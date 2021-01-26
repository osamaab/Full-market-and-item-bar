//
//  QuantitySelectionView.swift
//  talabyeh
//
//  Created by Hussein Work on 24/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class QuantitySelectionView: UIControl {
    
    /**
     A style defines the dimensions of the quantity selection view, small fits content like cells in list, and big fits a more bigger view.
     */
    enum Style {
        case big
        case small
    }
    
    let verticalStackView: UIStackView = .init()
    let valueStackView: UIStackView = .init()
    
    let plusButton: UIButton = .init()
    let minusButton: UIButton = .init()
    let valueLabel: UILabel = .init()
    let titleLabel: UILabel = .init()
    
    var title: String? {
        didSet {
            titleLabel.isHidden = title == nil || (title ?? "").isEmpty
        }
    }
    
    var minValue: Int {
        didSet {
            if value < minValue {
                self.value = maxValue
            }
        }
    }
    
    var maxValue: Int {
        didSet {
            if value > maxValue {
                self.value = maxValue
            }
        }
    }
    
    var value: Int {
        didSet {
            self.valueLabel.text = "\(value)"
        }
    }
    
    let style: Style

    init(style: Style, title: String?, minValue: Int = 1, maxValue: Int = 100) {
        self.style = style
        self.title = title
        self.minValue = minValue
        self.maxValue = maxValue
        self.value = minValue
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        self.style = .small
        self.title = nil
        self.minValue = 1
        self.maxValue = 100
        self.value = minValue
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        let spacing: CGFloat = style == .big ? 15 : 5
        let fontSizeForTitle: CGFloat = style == .big ? 14 : 10
        
        addSubview(verticalStackView)
        verticalStackView.alignment(.center)
            .distribution(.fill)
            .spacing(spacing)
            .axis(.vertical)
            .preparedForAutolayout()
        
        verticalStackView.fillContainer()
        
        verticalStackView.addingArrangedSubviews {
            titleLabel
            valueStackView
        }
        
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.textColor = DefaultColorsProvider.secondaryText
        titleLabel.font = .font(for: .medium, size: fontSizeForTitle)
        titleLabel.isHidden = title == nil || (title ?? "").isEmpty
        
        setupValueStack()
    }
    
    func setupValueStack(){
        
        plusButton.Height == minusButton.Height
        plusButton.Height == plusButton.Width
        minusButton.Height == minusButton.Width
        
        valueStackView.addingArrangedSubviews {
            minusButton
            valueLabel
            plusButton
        }

        let valuesSpacing: CGFloat = style == .big ? 25 : 10
        
        valueStackView
            .alignment(.fill)
            .distribution(.equalSpacing)
            .axis(.horizontal)
            .spacing(valuesSpacing)
            .preparedForAutolayout()
        
        let paddingValue: CGFloat = style == .big ? 10 : 4
        let valueFontSize: CGFloat = style == .big ? 27 : 18
        
        minusButton.contentEdgeInsets = .init(top: paddingValue, left: paddingValue, bottom: paddingValue, right: paddingValue)
        plusButton.contentEdgeInsets = .init(top: paddingValue, left: paddingValue, bottom: paddingValue, right: paddingValue)

        
        
        plusButton.layer.borderWidth = 0.2
        plusButton.layer.borderColor = DefaultColorsProvider.text.cgColor
        plusButton.setImage(UIImage(named: "plus_small"), for: .normal)
        plusButton.layer.cornerRadius = 3
        plusButton.tintColor = DefaultColorsProvider.text
        
        minusButton.layer.borderWidth = 0.2
        minusButton.layer.borderColor = DefaultColorsProvider.text.cgColor
        minusButton.setImage(UIImage(named: "plus_small"), for: .normal)
        minusButton.layer.cornerRadius = 3
        minusButton.tintColor = DefaultColorsProvider.text

        
        valueLabel.font = .font(for: .bold, size: valueFontSize)
        valueLabel.text = "\(value)"
        valueLabel.textAlignment = .center
        
        plusButton.add(event: .touchUpInside) { [unowned self] in
            let newValue = self.value + 1
            if newValue <= self.maxValue {
                self.value = newValue
            }
            
            self.sendActions(for: .valueChanged)
        }
        
        minusButton.add(event: .touchUpInside) { [unowned self] in
            let newValue = self.value - 1
            if newValue >= self.minValue {
                self.value = newValue
            }
            
            self.sendActions(for: .valueChanged)
        }
    }
}
