//
//  UserTaskOperatorType.swift
//  talabyeh
//
//  Created by Hussein Work on 26/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Promises
import AwaitToast

/**
 A Task operator can simply be defined as an object in which executes a specific task with a managed state changes.
 
 For Example, let's say we have a login task, the default flow would be:
 - ask to perform the task ( on the receiver )
 - the receiver prepares for this task
 - once the task finishes, the receiver prepares for the completion of this task
 - if result is succesful, handle the success result
 - if not, handle the task failure
 */
protocol UserTaskOperator {
    
    /**
     Performs the given task async and gets it's result throught default handle task result method :)
     */
    func performTask<R>(taskOperation: Promise<R>) -> Promise<R>
    
    /**
     Prepares the receiver for the given task, this should block the interaction for the receiver.
     */
    func prepareForTask<R>(taskOperation: Promise<R>)
        
    /**
    When Something wents wrong,
    */
    func handleTaskFailure(with error: Error)
      
    /**
    When something wents ok!
    */
    func handleTaskSuccess<R>(result: R)
}

extension UserTaskOperator {
    func performTask<R>(taskOperation: Promise<R>) -> Promise<R> {
        prepareForTask(taskOperation: taskOperation)
            
        return taskOperation.then { result in
            self.handleTaskSuccess(result: result)
        }.catch { error in
            self.handleTaskFailure(with: error)
        }
    }
}


extension UIViewController: UserTaskOperator {
    func prepareForTask<R>(taskOperation: Promise<R>) {
        self.startAnimating()
    }
    
    func handleTaskSuccess<R>(result: R) {
        self.stopAnimating()
    }
    
    func handleTaskFailure(with error: Error) {
        self.stopAnimating()
        showMessage(message: error.localizedDescription, messageType: .failure)
    }
}
