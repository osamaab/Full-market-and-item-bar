//
//  DistributorStatusContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 24/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class DistributorStatusContentView: BasicViewWithSetup {

    let containerStackView = UIStackView().then {
        $0.distribution(.fill).alignment(.fill).axis(.vertical).spacing(10)
    }
    
    fileprivate lazy var openStatusView = StatusOptionView(contentView: nil).then {
        $0.imageView.image = .named("status_open")
        $0.titleLabel.text = "Open"
    }
    
    fileprivate lazy var closeStatusView = StatusOptionView(contentView: closeMoreInformationView).then {
        $0.imageView.image = .named("status_closed")
        $0.titleLabel.text = "Closed"
    }
    
    fileprivate lazy var disabledStatusView = StatusOptionView(contentView: nil).then {
        $0.imageView.isHidden = true
        $0.titleLabel.text = "Disabled"
    }
    
    fileprivate lazy var closeMoreInformationView = StatusMoreInformationView()
    
    
    var selectedCheckboxIndex: Int = 0 {
        didSet {
            resetSelectionState()
        }
    }
    
    override func setup() {
        backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        subviewsPreparedAL { () -> [UIView] in
            containerStackView
        }
        
        containerStackView.leading(0).trailing(0).top(20).bottom(20)
        containerStackView.addingArrangedSubviews {
            openStatusView
            closeStatusView
            disabledStatusView
        }
        
        openStatusView.checkbox.add(gesture: .tap(1)) { [unowned self] in
            selectedCheckboxIndex = 0
        }
        
        closeStatusView.checkbox.add(gesture: .tap(1)) { [unowned self] in
            selectedCheckboxIndex = 1
        }
        
        disabledStatusView.checkbox.add(gesture: .tap(1)) { [unowned self] in
            selectedCheckboxIndex = 2
        }
        
        resetSelectionState()
    }
    
    fileprivate func resetSelectionState(){
        self.openStatusView.checkbox.isSelected = selectedCheckboxIndex == 0
        self.closeStatusView.checkbox.isSelected = selectedCheckboxIndex == 1
        self.disabledStatusView.checkbox.isSelected = selectedCheckboxIndex == 2
    }
}

private class StatusMoreInformationView: BasicViewWithSetup {
    
    let containerStackView = UIStackView().then {
        $0.distribution(.fill).alignment(.fill).axis(.vertical).spacing(10)
    }
    
    
    let daysTextField = WeekdaysRangePickerTextField().then {
        $0.placeholder = "Days"
    }
    
    let timesTextField = TimeRangePickerTextField().then {
        $0.placeholder = "Times"
    }
    
    let reasonTextView = TextView().then {
        $0.placeholder = "Reason"
    }
    
    override func setup() {
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        subviewsPreparedAL {
            containerStackView
        }
        
        containerStackView.leading(0).trailing(0).top(0).bottom(0)
        containerStackView.addingArrangedSubviews {
            daysTextField
            timesTextField
            reasonTextView
        }
        
        reasonTextView.height(200)
    }
}


private class StatusOptionView: BasicCardView {
    
    let containerStackView: UIStackView = .init()
    let imageView: UIImageView = .init()
    let titleLabel: UILabel = .init()
    let checkbox: CheckboxView = .init()
    
    let contentView: UIView?
    
    init(contentView: UIView? = nil){
        self.contentView = contentView
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup(){
        super.setup()
        
        subviewsPreparedAL {
            containerStackView
            checkbox
        }
        
        containerStackView.addingArrangedSubviews {
            imageView
            titleLabel
        }
        
        containerStackView.leading(20).top(20).centerHorizontally()
        containerStackView.distribution(.fill).alignment(.center).axis(.horizontal).spacing(8)
        
        checkbox.trailing(20)
        checkbox.height(25).width(25)
        checkbox.CenterY == containerStackView.CenterY
        
        imageView.contentMode = .scaleAspectFit
        imageView.height(35).width(35)
        
        titleLabel.font = .font(for: .medium, size: 18)
        titleLabel.textColor = DefaultColorsProvider.tintPrimary
        
        if let contentView = self.contentView {
            subviewsPreparedAL { () -> [UIView] in
                contentView
            }
            
            contentView.leading(20).centerHorizontally()
            contentView.Top == containerStackView.Bottom + 20
            contentView.Bottom == Bottom - 20
        } else {
            containerStackView.bottom(20)
        }
    }
}
