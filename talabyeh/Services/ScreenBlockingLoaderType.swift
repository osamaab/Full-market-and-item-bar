//
//  ScreenBlockingLoaderType.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Stevia

/**
 A Type that presents an on-screen loader ( context independant ), think of it as a generic approach for implementing ProgressHUD
 */
protocol ScreenBlockingLoaderType: class {
    /**
     Shows the activity indicator view blocking the UI
     */
    static func startAnimating()
    
    /**
     Hides the activity indicator view blocking the UI
     */
    static func stopAnimating()
}


extension UIViewController {
    
    /**
     Internally we use one of the loaders provided
     */
    fileprivate var loaderPresenter: ScreenBlockingLoaderType.Type {
        NVActivityIndicatorPresenter.self
    }
    
    
    func startAnimating() {
        loaderPresenter.startAnimating()
    }
    
    func stopAnimating() {
        loaderPresenter.stopAnimating()
    }
}



public final class NVActivityIndicatorPresenter: ScreenBlockingLoaderType {
        
    static let window = AppDelegate.shared.window
    static let restorationIdentifier = "NVActivityIndicatorViewContainer"
    
    class func startAnimating() {
        guard let window = self.window else {
            return
        }
        
        let containerView = UIView(frame: UIScreen.main.bounds)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let fadeInAnimation: FadeInAnimation = NVActivityIndicatorView.DEFAULT_FADE_IN_ANIMATION

        containerView.backgroundColor = DefaultColorsProvider.backgroundPrimary.withAlphaComponent(0.5)
        containerView.restorationIdentifier = Self.restorationIdentifier
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        fadeInAnimation(containerView)
        
        let blockerSize = CGSize(width: 60, height: 60)

        let activityIndicatorView = NVActivityIndicatorView(
            frame: CGRect(x: 0, y: 0, width: blockerSize.width, height: blockerSize.height),
            type: .ballBeat,
            color: DefaultColorsProvider.backgroundPrimary,
            padding: 0)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false

        activityIndicatorView.startAnimating()
        containerView.addSubview(activityIndicatorView)
        
        activityIndicatorView.height(60)
        activityIndicatorView.width(60)
        activityIndicatorView.centerInContainer()
        

        window.addSubview(containerView)
        containerView.fillContainer()
    }

    class func stopAnimating() {
        let fadeOutAnimation: FadeOutAnimation = NVActivityIndicatorView.DEFAULT_FADE_OUT_ANIMATION
        
        for window in UIApplication.shared.windows {
            for item in window.subviews
            where item.restorationIdentifier == Self.restorationIdentifier {
                fadeOutAnimation(item) {
                    item.removeFromSuperview()
                }
            }
        }
    }
}
