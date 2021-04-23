//
//  ContentViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 05/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit


class ContentViewController<ContentType>: StatefulViewController<ContentType>,
                                          ContentRepositoryType {
    
    
    /**
     The entity responsable for getting the content
     */
    let contentRepository: AnyContentRepository<ContentType>
    
    
    /**
     Returns the content if exists, this only happens when the state == .hasContent, otherwise, null
     */
    var content: ContentType? {
        state.content
    }
    
    var unwrappedContent: ContentType {
        state.content!
    }
    
    /**
     When true, the content view controller won't transition immeditly to the content state until authentication is passed.
     */
    var requiresAuthentication: Bool {
        false
    }
    
    /**
     The authentiication manager to use for observing authentication state.
     */
    var authenticationProvider: AuthenticationManagerType {
        DefaultAuthenticationManager.shared
    }
    
    init<Repository: ContentRepositoryType>(contentRepository: Repository) where Repository.ContentType == ContentType {
        if let anyRepo = contentRepository as? AnyContentRepository<ContentType> {
            self.contentRepository = anyRepo
        } else {
            self.contentRepository = AnyContentRepository(contentRepository)
        }
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        unAuthenticatedStateView.signInButton.add(event: .touchUpInside) {
            AppDelegate.shared.router.trigger(.authentication(.signin))
        }
        
        unAuthenticatedStateView.signUpButton.add(event: .touchUpInside) {
            guard let currentUserType = UserDefaultsPreferencesManager.shared.userType else {
                return
            }
            
            guard let categories = DefaultPreferencesController.shared.selectedCategories else {
                return
            }
            guard let subCategories = DefaultPreferencesController.shared.selectedSubCategories else {
                return
            }
            
            AppDelegate.shared.router.trigger(.authentication(.signup(currentUserType, categories, subCategories)))
        }

        performContentRequest()
    }
    
    override func retry() {
        self.performRetry()
    }
    
    func performRetry(){
        self.performContentRequest()
    }
    
    
    func performContentRequest(){
        let isAuthenticated = self.authenticationProvider.isAuthenticated
        if requiresAuthentication && !isAuthenticated {
            transition(to: .unAuthenticated(nil))
            return
        }
        
        
        self.contentRequestWillStart()
        
        /**
         The view begins by transitioning the context into loading state
         */
        self.transition(to: .loading)
        
        /**
         Now, perform the request of the content, returning a result
         */
        self.requestContent { (result) in
            self.contentRequestDidFinish(with: result)
            switch result {
            /**
             In case of failure return value, transition to failure state
             */
            case .failure(let error):
                self.transition(to: .failure(error))
                self.contentRequestDidFail(with: error)
                break
            case .success(let content as Emptiable):
                if content.isEmpty {
                    self.transition(to: .empty(content.emptyMessage ?? ""))
                } else {
                    self.transition(to: .hasContent(content as! ContentType))
                }
                
                self.contentRequestDidSuccess(with: content as! ContentType)
                break
            case .success(let content):
                self.transition(to: .hasContent(content))
                self.contentRequestDidSuccess(with: content)
                break
            }
        }
    }
    
    func requestContent(completion: @escaping ContentRequestCompletion<ContentType>) {
        self.contentRepository.requestContent(completion: completion)
    }
    
    func contentRequestWillStart(){
        
    }
    
    func contentRequestWillRetry(){
        
    }
    
    func contentRequestDidFinish(with result: Result<ContentType, Error>){
        
    }
    
    func contentRequestDidFail(with error: Error){
        
    }
    
    func contentRequestDidSuccess(with content: ContentType){
        
    }
}
