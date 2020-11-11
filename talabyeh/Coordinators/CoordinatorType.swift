//
//  CoordinatorType.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit

/**
 A Coordinator is simply defined as a flow manager, in which directs one screen to another within the same flow.
 */
protocol CoordinatorType: class {
    
    /**
     Defines the root navigation of the coordinator
     */
    var rootViewController: UIViewController? { get }
    
    /**
     tells the coordinator to start it's transitioning, while the transition type isn't yet defined, in later versions we'll specify the transition type with the default implementation, but for now, let's keep things as they are.
     */
    func start()
    
    
    /**
     Called when the coordinator is just about to start the transition
     */
    func prepareToStart()
    
    /**
     Called when the coordinator will hide
     */
    func prepareToHide()
}


extension CoordinatorType {
    
    
    func prepareToStart(){
        
    }
    
    func prepareToHide(){
        
    }
}
