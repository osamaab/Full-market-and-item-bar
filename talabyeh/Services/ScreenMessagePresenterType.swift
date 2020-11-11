//
//  ScreenMessagePresenterType.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import AwaitToast

public enum TaskMessageType {
    case success
    case failure
    case notice
    
    var color: UIColor {
        switch self {
        case .success:
            return DefaultColorsProvider.success
        case .failure:
            return DefaultColorsProvider.error
        case .notice:
            return DefaultColorsProvider.notice
        }
    }
}

/**
 A type that presents a message into the screen, using alert or toast like.
 */
protocol ScreenMessagePresenterType: class {
    func show(message: String, messageType: TaskMessageType)
}




extension UIViewController {
    
    fileprivate var messagePresenter: ScreenMessagePresenterType {
        ToastScreenMessagePresenter.shared
    }
    
    /**
     Shortcut to let any view controller benifit from the current used message presenter
     */
    func showMessage(message: String?, messageType: TaskMessageType){
        guard let message = message else {
            return
        }
        
        messagePresenter.show(message: message, messageType: messageType)
    }
}

/**
 A Type that uses AwaitToast library to present messages on the top of the screen, given some insets and automatic height.
 */
class ToastScreenMessagePresenter: ScreenMessagePresenterType {
    
    static let shared: ToastScreenMessagePresenter = .init()
    
    
    func show(message: String, messageType: TaskMessageType) {
        ToastAppearanceManager.default.backgroundColor = messageType.color
        ToastAppearanceManager.default.numberOfLines = 0
        ToastAppearanceManager.default.height = AutomaticDimension
        ToastAppearanceManager.default.titleEdgeInsets = .init(top: 8, left: 20, bottom: 8, right: 20)
        ToastAppearanceManager.default.textColor = .white
        
        
        let toast = Toast.default(text: message, direction: .top)
        toast.show()
    }
}
